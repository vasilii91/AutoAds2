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
    _vehicleModels = [NSMutableArray new];
    
    if ([subrubrics count] != 0) {
        NSArray *subrubricDictionaries = [subrubrics allValues];
        for (NSDictionary * d in subrubricDictionaries) {
            VehicleModel *vm = [[VehicleModel alloc] initWithDictionary:d];
            [_vehicleModels addObject:vm];
        }
    }
}

- (NSMutableArray *)vehicleModels
{
    NSComparisonResult (^sortBlock)(id, id) = ^(id obj1, id obj2) {
        
        NSInteger order1 = [((VehicleModel *)obj1).order integerValue];
        NSInteger order2 = [((VehicleModel *)obj2).order integerValue];
        
        if (order1 > order2) {
            return NSOrderedDescending;
        }
        else if (order1 < order2) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    };
    
    NSMutableArray *result = [[NSMutableArray alloc] initWithArray:[_vehicleModels sortedArrayUsingComparator:sortBlock]];
    return result;
}

@end
