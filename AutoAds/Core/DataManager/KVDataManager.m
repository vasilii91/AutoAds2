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
        self.selectedOptions = [NSMutableSet new];
        self.selectedFuels = [NSMutableSet new];
        self.selectedModels = [NSMutableSet new];
        self.selectedStates = [NSMutableSet new];
        self.selectedPhones = [NSMutableArray new];
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

- (void)saveData:(NSOutputStream *)outputStream withRequestType:(int)type identifier:(NSString *)identifier
{
    if (type == RequestTypePhotosOfCar) {
        [FileManagerCoreMethods createNewDirectoryWithName:DEFAULT_PHOTOS_DIRECTORY_NAME];
        
        NSData *data = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.%@", PHOTOS_DIRECTORY, identifier, PHOTOS_EXTENSION];
        [data writeToFile:filePath atomically:YES];
        
        self.countOfLoadedImages++;
        NSInteger necessaryCount = [[[NSUserDefaults standardUserDefaults] valueForKey:COUNT_OF_PHOTOS_IN_CAR_PHOTOS] integerValue];
        if (self.countOfLoadedImages == necessaryCount) {
            [self.delegate dataWasSuccessfullyParsed];
        }
    }
    else if (type == RequestTypeGetCaptcha) {
        NSData *data = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        [data writeToFile:PATH_TO_CAPTCHA_IMAGE atomically:YES];
        
        [self.delegate dataWasSuccessfullyParsed];
    }
    else {
        NSData *data = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        LOG(@"%@", str);
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *parseData = [parser objectWithString:str];
        
        NSInteger errorCode = [[parseData objectForKey:@"error"] integerValue];
        
        if (errorCode == 0) {
            if (type == RequestTypeSearch) {
                _currentPage = [[parseData valueForKey:@"Page"] integerValue];
                _totalCount = [[parseData valueForKey:@"Total"] integerValue];
                
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
            else if (type == RequestTypeOptions) {
                NSString *format = [parseData valueForKey:@"Format"];
                self.options = [NSMutableArray new];
                
                if ([format isEqualToString:@"Options"]) {
                    NSDictionary *dict = [parseData valueForKey:format];
                    for (NSString *key in [dict allKeys]) {
                        NSString *value = [dict objectForKey:key];
                        Option *option = [Option new];
                        option.id = [key integerValue];
                        option.title = value;
                        [self.options addObject:option];
                    }
                }
                else if ([format isEqualToString:@"OptionsCategories"]) {
                    NSArray *arr = [parseData valueForKey:format];
                    for (NSDictionary *d in arr) {
                        NSString *title = [d objectForKey:@"title"];
                        NSDictionary *dict = [d objectForKey:@"fields"];
                        
                        OptionsCategory *optionCategory = [OptionsCategory new];
                        optionCategory.title = title;
                        
                        for (NSString *key in [dict allKeys]) {
                            NSString *value = [dict objectForKey:key];
                            Option *option = [Option new];
                            option.id = [key integerValue];
                            option.title = value;
                            [optionCategory.fields addObject:option];
                        }
                        [self.options addObject:optionCategory];
                    }
                }
                
            }
            [self.delegate dataWasSuccessfullyParsed];
        }
        else if (errorCode == 1) {
            NSString *errorText = [parseData objectForKey:@"errorText"];
            [self.delegate errorWasOccuredWithError:errorText];
        }
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

- (void)cleanAllTempData
{
    [self.selectedFuels removeAllObjects];
    [self.selectedModels removeAllObjects];
    [self.selectedOptions removeAllObjects];
    [self.selectedStates removeAllObjects];
    [self.selectedPhones removeAllObjects];
}

@end
