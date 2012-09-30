//
//  AdvGroup.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/7/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvField.h"

enum
{
    GroupTypeJoined,
    GroupTypeMerged,
    GroupTypeMain,
    GroupTypeBrands,
    GroupTypeGeneral,
    GroupTypeAddAdvertisement,
    GroupTypeSearch,
    GroupTypePassengerCar,
    GroupTypeTrailerForCar,
    GroupTypeBus,
    GroupTypeTruck,
    GroupTypeMKT,
    GroupTypeTrailerForTruckCar,
    GroupTypeSpecialTechnique,
    GroupTypeMotoTechnique,
    GroupTypeHydroCycle,
    GroupTypeCuttersAndYachts,
    GroupTypeBoats,
    GroupTypeAutoparts,
    GroupTypeTires,
    GroupTypeDisks
};
typedef NSUInteger GroupType;

@interface AdvGroup : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) GroupType type;
@property (nonatomic, retain) NSArray *fields;

- (NSArray *)getObligatoryFields;
- (void)printFields;

@end
