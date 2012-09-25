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

- (NSString *)getCarName
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
    return [NSString stringWithFormat:@"%@ руб.", _Price];
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
@end
