//
//  VehicleModel.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "VehicleModel.h"

@implementation VehicleModel

+ (Class)subrubrics_class
{
    return [VehicleModification class];
}

- (void)setSubrubrics:(NSDictionary *)subrubrics
{
    self.vehicleModifications = [NSMutableArray new];
    
    if ([subrubrics count] != 0) {
        if ([subrubrics isKindOfClass:[NSDictionary class]]) {
            VehicleModification *vm = [[VehicleModification alloc] initWithDictionary:subrubrics];
            [self.vehicleModifications addObject:vm];
        }
        else if ([subrubrics isKindOfClass:[NSArray class]]) {
            NSArray *subrubricDictionaries = [subrubrics allValues];
            for (NSDictionary * d in subrubricDictionaries) {
                VehicleModification *vm = [[VehicleModification alloc] initWithDictionary:d];
                [self.vehicleModifications addObject:vm];
            }
        }
    }
}

@end
