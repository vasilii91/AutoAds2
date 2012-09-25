//
//  KVDataManager.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KVDataManager.h"

static KVDataManager *instance = nil;

@implementation KVDataManager

#pragma mark - Memory management

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

+ (KVDataManager *)sharedInstance
{
	if (instance == nil) {
		instance = [[KVDataManager alloc] init];
	}
	
	return instance;
}

#pragma mark - Public methods

- (void)saveData:(NSOutputStream *)outputStream withRequestType:(int)type
{
    if (type == RequestTypeLogin) {
        for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies])
        {
            NSString *currentCookie = [NSString stringWithFormat:@".ASPXAUTH: %@", [cookie value]];
            LOG(@"cookie - %@", currentCookie);
        }
    }
    else {
        NSData *data = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *parseData = [parser objectWithString:str];
        
        if (type == RequestTypeSearch) {
            NSArray *advertisementsArray = [parseData valueForKey:@"Ads"];
            self.advertisements = [NSMutableArray new];
            
            for (NSDictionary *d in advertisementsArray) {
                Advertisement *advertisement = [[Advertisement alloc] initWithDictionary:d];
                [self.advertisements addObject:advertisement];
            }
        }
        else if (type == RequestTypeBrands) {
            NSArray *arr = [parseData valueForKey:@"Brands"];
            self.brands = [NSMutableArray new];
            
            for (NSDictionary *d in arr) {
                VehicleBrand *brand = [[VehicleBrand alloc] initWithDictionary:d];
                [self.brands addObject:brand];
            }
        }
        
        [self.delegate dataWasSuccessfullyParsed];
    }
}

- (NSDictionary *)brandsDictionary
{
    OrderedDictionary *brandsDict = [OrderedDictionary new];
    
    for (VehicleBrand *brand in self.brands) {
        [brandsDict setValue:brand.id forKey:brand.title];
    }
    
    return brandsDict;
}

- (NSString *)brandNameById:(NSString *)brandId
{
    for (NSString *brandName in [self brandsDictionary]) {
        NSString *_brandId = [[self brandsDictionary] valueForKey:brandName];
        if ([brandId integerValue] == [_brandId integerValue]) {
            return brandName;
        }
    }
    
    return nil;
}

- (NSDictionary *)modelsDictionary
{
    VehicleBrand *currentBrand = [self currentBrand];
    OrderedDictionary *modelsDict = [OrderedDictionary new];
    
    if (currentBrand != nil) {
        for (VehicleModel *model in currentBrand.vehicleModels) {
            [modelsDict setValue:model.id forKey:model.title];
        }
    }
    
    return modelsDict;
}

- (NSString *)modelNameById:(NSString *)modelId
{
    for (NSString *modelName in [self modelsDictionary]) {
        NSString *_modelId = [[self brandsDictionary] valueForKey:modelName];
        if ([modelId integerValue] == [_modelId integerValue]) {
            return modelName;
        }
    }
    
    return nil;
}

- (NSDictionary *)modificationsDictionary
{
    VehicleModel *currentBrand = [self currentModel];
    OrderedDictionary *modificationsDict = [OrderedDictionary new];
    
    if (currentBrand != nil) {
        for (VehicleModel *model in currentBrand.vehicleModifications) {
            [modificationsDict setValue:model.id forKey:model.title];
        }
    }
    
    return modificationsDict;
}

- (NSString *)modificationNameById:(NSString *)modificationId
{
    for (NSString *modificatonName in [self modelsDictionary]) {
        NSString *_modificationId = [[self brandsDictionary] valueForKey:modificatonName];
        if ([modificationId integerValue] == [_modificationId integerValue]) {
            return modificatonName;
        }
    }
    
    return nil;
}


#pragma mark - Private methods

- (VehicleBrand *)currentBrand
{
    NSString *currentBrandTitle = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_BRAND];
    
    VehicleBrand *currentBrand = nil;
    if (currentBrandTitle != nil) {
        for (VehicleBrand *brand in self.brands) {
            if ([brand.title isEqualToString:currentBrandTitle]) {
                currentBrand = brand;
                break;
            }
        }
    }
    
    return currentBrand;
}

- (VehicleModel *)currentModel
{
    NSString *currentModelTitle = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_MODEL];
    VehicleBrand *currentBrand = [self currentBrand];
    
    VehicleModel *currentModel = nil;
    if (currentModelTitle != nil && currentBrand != nil) {
        for (VehicleModel *model in currentBrand.vehicleModels) {
            if ([model.title isEqualToString:currentModelTitle]) {
                currentModel = model;
                break;
            }
        }
    }
    
    return currentModel;
}

@end
