//
//  AdvDictionaries.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderedDictionary.h"
#import "AdvFieldNames.h"
#import "Constants.h"

@interface AdvDictionaries : NSObject

#pragma mark - Logo

+ (NSString *)Logo;


#pragma mark - Our projects

+ (NSDictionary *)OurProjects;


#pragma mark - Cities

+ (NSDictionary *)Cities;

+ (NSDictionary *)Cities2;
+ (NSDictionary *)Cities16;
+ (NSDictionary *)Cities29;
+ (NSDictionary *)Cities34;
+ (NSDictionary *)Cities59;
+ (NSDictionary *)Cities61;
+ (NSDictionary *)Cities63;
+ (NSDictionary *)Cities72;
+ (NSDictionary *)Cities74;
+ (NSDictionary *)Cities76;


#pragma mark - Colors

+ (NSDictionary *)WheelColors;
+ (NSDictionary *)VehicleColors;


#pragma mark - BodyTypes

+ (NSDictionary *)BodyTypesRusForeign;
+ (NSDictionary *)BodyTypesBuses;
+ (NSDictionary *)BodyTypesTrucks;
+ (NSDictionary *)BodyTypesSmall;
+ (NSDictionary *)BodyTypesTrailers;
+ (NSDictionary *)BodyTypesSpecial;
+ (NSDictionary *)BodyTypesBikes;


#pragma mark - DriveTypes

+ (NSDictionary *)DriveTypesRusForeign;
+ (NSDictionary *)DriveTypesBusesSmallSpecial;
+ (NSDictionary *)DriveTypesTrucks;


#pragma mark - CabinTypes

+ (NSDictionary *)CabinTypes;


#pragma mark - Other

+ (NSDictionary *)WheelMaterials;
+ (NSDictionary *)SpikesTypes;
+ (NSDictionary *)TiresWidthes;
+ (NSDictionary *)TiresHeights;
+ (NSDictionary *)TiresDiameters;
+ (NSDictionary *)WheelDiameters;
+ (NSDictionary *)WheelSorties;
+ (NSDictionary *)WheelWidthes;
+ (NSDictionary *)WheelHoleDiameters;
+ (NSDictionary *)WheelHoleCounts;
+ (NSDictionary *)WheelTypes;
+ (NSDictionary *)Seasonalities;
+ (NSDictionary *)TrailerDestinies;
+ (NSDictionary *)AdPeriods;
+ (NSDictionary *)Bools;
+ (NSDictionary *)EngineCapacities;
+ (NSDictionary *)FuelTypes;
+ (NSDictionary *)Rudder;
+ (NSDictionary *)GearboxTypes;
+ (NSDictionary *)GearboxTypesTrucks;
+ (NSDictionary *)GearboxTypesMKT;
+ (NSDictionary *)EngineTypes;
+ (NSDictionary *)Years;
+ (NSDictionary *)Counts;
+ (NSDictionary *)ModerateStatuses;
+ (NSDictionary *)HydrosTypes;


#pragma mark - States

+ (NSDictionary *)StatesGears;
+ (NSDictionary *)StatesWater;
+ (NSDictionary *)StatesCar;


#pragma mark - Subrubrics

+ (NSDictionary *)SubrubricsMotors;
+ (NSDictionary *)SubrubricsCommercial;
+ (NSDictionary *)SubrubricsMoto;
+ (NSDictionary *)SubrubricsWater;
+ (NSDictionary *)SubrubricsParts;


#pragma mark - Main

+ (NSDictionary *)Rubrics;
+ (NSDictionary *)RubricsWithSubrubrics;
+ (NSDictionary *)RubricsForAutoparts;
+ (NSDictionary *)HostLinks;
+ (NSDictionary *)Regions;


#pragma mark - Synonims

+ (NSDictionary *)SynonimsOfFields;


#pragma mark - AddAdvertisement fields

+ (NSDictionary *)AddAdvertisementFields;


#pragma mark - Public methods

+ (NSString *)valueFromDictionary:(NSDictionary *)dictionary forKeyOrValue:(NSString *)keyOrValue;

@end
