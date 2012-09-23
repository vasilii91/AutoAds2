//
//  VehicleBrand.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "VehicleBrand.h"

@implementation VehicleBrand

+ (Class)subrubrics_class
{
    return [VehicleModel class];
}

- (void)setSubrubrics:(NSDictionary *)subrubrics
{
    self.vehicleModels = [NSMutableArray new];
    
    if ([subrubrics count] != 0) {
        NSArray *subrubricDictionaries = [subrubrics allValues];
        for (NSDictionary * d in subrubricDictionaries) {
            VehicleModel *vm = [[VehicleModel alloc] initWithDictionary:d];
            [self.vehicleModels addObject:vm];
        }
    }
}

@end
