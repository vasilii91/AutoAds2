//
//  Advertisement.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "Advertisement.h"

@implementation Advertisement

+ (Class)Photo_class
{
    return [PhotoContainer class];
}

+ (Class)Options_class
{
    return [NSArray class];
}

- (NSDate *)getDateCreated
{
    return [KVDataLogic dateWithMilliseconds:self.DateCreate];
}

- (NSString *)getFullCarName
{
    KVDataManager *dataManager = [KVDataManager sharedInstance];
    
    NSString *brandName = [dataManager brandNameById:_Brand];
    NSString *modelName = [dataManager modelNameById:_Model];
    NSString *modificationName = [dataManager modelNameById:_Modification];
    
    NSMutableString *carName = [NSMutableString new];
    if (brandName != nil) {
        [carName appendString:brandName];
        [carName appendString:@" "];
    }
    if (modelName != nil) {
        [carName appendString:modelName];
        [carName appendString:@" "];
    }
    if (modificationName != nil) {
        [carName appendString:modificationName];
    }
    
    return carName;
}

- (NSString *)getCarPrice
{
    return [NSString stringWithFormat:@"%d руб.", [_Price integerValue]];
}

- (NSString *)getOtherInfo
{
    NSMutableString *carOtherInfo = [NSMutableString new];
    if (_Year != nil) {
        [carOtherInfo appendFormat:@"%@ г., ", _Year];
    }
    if (_Mileage != nil) {
        [carOtherInfo appendFormat:@"%@ км., ", _Mileage];
    }
    if (_Type != nil) {
        [carOtherInfo appendString: _Type];
    }
    
    return carOtherInfo;
}

- (NSString *)getNameAndCity
{
    NSMutableString *nameAndCity = [NSMutableString new];
    if (_Contacts != nil) {
        [nameAndCity appendString:_Contacts];
    }
    if (_CityCode != nil) {
        NSString *cityName = [AdvDictionaries valueFromDictionary:[AdvDictionaries Cities] forKeyOrValue:_CityCode];
        if (cityName != nil) {
            [nameAndCity appendFormat:@", %@", cityName];
        }
    }
    return nameAndCity;
}
@end
