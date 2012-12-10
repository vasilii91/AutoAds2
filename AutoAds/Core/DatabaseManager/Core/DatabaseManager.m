//
//  DatabaseManager.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/30/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager


#pragma mark - Initialization

static DatabaseManager *_sharedMySingleton = nil;

- (id)init
{
    self = [super init];
    if (self) {
        currentManagedObjectContext = [NSManagedObjectContext contextForCurrentThread];
    }
    
    return self;
}

+ (DatabaseManager *)sharedMySingleton
{
    @synchronized(self)
    {
        if (!_sharedMySingleton) {
            _sharedMySingleton = [[DatabaseManager alloc] init];
        }
    }
    
    return _sharedMySingleton;
}


#pragma mark - Public methods

- (void)saveAll
{
    [currentManagedObjectContext save];
}

- (NSManagedObject *)createEntityByClass:(Class)klass
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(klass) inManagedObjectContext:currentManagedObjectContext];
}

- (BOOL)deleteEntity:(NSManagedObject *)managedObject
{
    BOOL result = [managedObject deleteInContext:currentManagedObjectContext];
    [currentManagedObjectContext save];
    
    return result;
}

- (NSArray *)getQueries:(BOOL)isSaved
{
    NSInteger countOfQueries = 5;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSaved == %@", @(isSaved)];
    NSArray *result = [Query findAllWithPredicate:predicate];
    
    NSComparisonResult (^sortBlock)(id, id) = ^(id obj1, id obj2) {
        
        Query *query1 = (Query *)obj1;
        Query *query2 = (Query *)obj2;
        
        NSComparisonResult result = [query1.dateAdded compare:query2.dateAdded];
        if (result == NSOrderedAscending) {
            return NSOrderedDescending;
        }
        else if (result == NSOrderedDescending) {
            return NSOrderedAscending;
        }
        else {
            return NSOrderedSame;
        }
    };
    
    result = [result sortedArrayUsingComparator:sortBlock];
    
    if (isSaved == NO) {
        if ([result count] <= countOfQueries) {
            return result;
        }
        else {
            // we always have 6 queries. We should delete last object
            NSMutableArray *newResult = [NSMutableArray new];
            for (int i = 0; i < countOfQueries; i++) {
                [newResult addObject:[result objectAtIndex:i]];
            }
            for (int i = countOfQueries; i < [result count]; i++) {
                Query *query = [result objectAtIndex:i];
                [currentManagedObjectContext deleteObject:query];
            }
            [self saveAll];
            
            return newResult;
        }
    }
    
    return result;
}

- (Query *)findQueryByQueryString:(NSString *)queryString isSaved:(BOOL)isSaved
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(queryString == %@) AND (isSaved == %@)", queryString, @(isSaved)];
    NSArray *result = [Query findAllWithPredicate:predicate];
    
    return [result count] == 0 ? nil : [result objectAtIndex:0];
}

- (void)addBrands:(NSMutableArray *)brands forRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    CachedData *cachedData = [self findCachedDataByRubric:rubric subrubric:subrubric isBrands:YES]; 
    if ([cachedData.brands count] != 0) {
        [cachedData removeBrands:cachedData.brands];
    }
    
    for (VehicleBrand *brand in brands) {
        Brand *_brand = (Brand *)[self createEntityByClass:[Brand class]];
        _brand.id = brand.id;
        _brand.title = brand.title;
        _brand.order = brand.order;
        
        for (VehicleModel *model in brand.vehicleModels) {
            Model *_model = (Model *)[self createEntityByClass:[Model class]];
            _model.id = model.id;
            _model.title = model.title;
            _model.order = model.order;
            
            for (VehicleModification *modification in model.vehicleModifications) {
                Modification *_modification = (Modification *)[self createEntityByClass:[Modification class]];
                _modification.id = modification.id;
                _modification.title = modification.title;
                
                // add modifications to model
                [_model addModificationsObject:_modification];
            }
            
            // add models to brand
            [_brand addModelsObject:_model];
        }
        
        // add brands to cached data
        [cachedData addBrandsObject:_brand];
    }
    
    [self saveAll];
}

- (void)addOptionsCategory:(NSMutableArray *)optionsCategory forRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    CachedData *cachedData = [self findCachedDataByRubric:rubric subrubric:subrubric isBrands:NO];
    if ([cachedData.optionCategories count] != 0) {
        [cachedData removeOptionCategories:cachedData.optionCategories];
    }
    
    for (OptionsCategory *optionCategory in optionsCategory) {
        OptionsCategories *_optionCategory = (OptionsCategories *)[self createEntityByClass:[OptionsCategories class]];
        _optionCategory.title = optionCategory.title;
        
        for (Option *option in optionCategory.fields) {
            Options *_option = (Options *)[self createEntityByClass:[Options class]];
            _option.title = option.title;
            _option.id = option.id;
            
            // add options to category
            [_optionCategory addOptionsObject:_option];
        }
        
        // add categories to cached data
        [cachedData addOptionCategoriesObject:_optionCategory];
    }
    
    [self saveAll];
}

- (NSMutableArray *)brandsByRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    CachedData *cachedData = [self findCachedDataByRubric:rubric subrubric:subrubric isBrands:YES];
    NSMutableArray *brands = [NSMutableArray new];
    
    for (Brand *_brand in cachedData.brands) {
        VehicleBrand *brand = [VehicleBrand new];
        brand.id = _brand.id;
        brand.title = _brand.title;
        brand.order = _brand.order;
        
        NSMutableArray *models = [NSMutableArray new];
        for (Model *_model in _brand.models) {
            VehicleModel *model = [VehicleModel new];
            model.id = _model.id;
            model.title = _model.title;
            model.order = _model.order;
            
            NSMutableArray *modifications = [NSMutableArray new];
            for (Modification *_modification in _model.modifications) {
                VehicleModification *modification = [VehicleModification new];
                modification.id = _modification.id;
                modification.title = _modification.title;
                
                [modifications addObject:modification];
            }
            model.vehicleModifications = modifications;
            
            [models addObject:model];
        }
        brand.vehicleModels = models;
        
        [brands addObject:brand];
    }
    
    return brands;
}

- (NSMutableArray *)optionCategoriesByRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    CachedData *cachedData = [self findCachedDataByRubric:rubric subrubric:subrubric isBrands:NO];
    NSMutableArray *optionCategories = [NSMutableArray new];
    
    for (OptionsCategories *_optionCategory in cachedData.optionCategories) {
        OptionsCategory *optionCategory = [OptionsCategory new];
        optionCategory.title = _optionCategory.title;
        
        NSMutableArray *options = [NSMutableArray new];
        for (Options *_option in _optionCategory.options) {
            Option *option = [Option new];
            option.id = _option.id;
            option.title = _option.title;
            
            [options addObject:option];
        }
        optionCategory.fields = options;
        
        [optionCategories addObject:optionCategory];
    }
    
    return optionCategories;
}


#pragma mark - Private methods

- (CachedData *)findCachedDataByRubric:(NSString *)rubric subrubric:(NSString *)subrubric isBrands:(BOOL)isBrands
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(rubric == %@) AND (subrubric == %@)", rubric, subrubric];
    NSArray *result = [CachedData findAllWithPredicate:predicate];
    
    CachedData *cachedData = [result count] == 0 ? nil : [result objectAtIndex:0];
    if (cachedData == nil) {
        cachedData = (CachedData *)[self createEntityByClass:[CachedData class]];
        cachedData.rubric = rubric;
        cachedData.subrubric = subrubric;
    }
    
    return cachedData;
}

@end
