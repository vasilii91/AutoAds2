//
//  SearchManager.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SearchManager.h"

@implementation SearchManager


#pragma mark - Initialization

static SearchManager *_sharedMySingleton = nil;

- (id)init
{
    self = [super init];
    if (self) {
        groups = [NSMutableArray new];
    }
    
    return self;
}

+ (SearchManager *)sharedMySingleton
{
    @synchronized(self)
    {
        if (!_sharedMySingleton) {
            _sharedMySingleton = [[SearchManager alloc] init];
            [_sharedMySingleton fillGroups];
        }
    }
    
    return _sharedMySingleton;
}


#pragma mark - Private methods

- (AdvGroup *)categoriesByRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    AdvGroup *subrubricGroup = nil;
    if ([subrubric isEqualToString:@"Отечественные авто"] ||
        [subrubric isEqualToString:@"Иномарки"]) {
        subrubricGroup = [groups objectAtIndex:1];
    }
    else if ([[[AdvDictionaries SubrubricsMoto] allKeys] containsObject:subrubric]) {
        subrubricGroup = [groups objectAtIndex:8];
    }
    else if ([rubric isEqualToString:@"Автозапчасти"]) {
        subrubricGroup = [groups objectAtIndex:12];
    }
    else {
        for (AdvGroup *group in groups) {
            if ([group.name isEqualToString:subrubric]) {
                subrubricGroup = group;
                break;
            }
        }
    }
    
    return subrubricGroup;
}

- (void)fillGroups
{
    [groups addObject:[self fillGeneralGroup]];
    [groups addObject:[self fillPassengerCarGroup]];
    [groups addObject:[self fillPassengerTrailerGroup]];
    [groups addObject:[self fillBusesGroup]];
    [groups addObject:[self fillTrucksGroup]];
    [groups addObject:[self fillMKTGroup]];
    [groups addObject:[self fillTruckTrailerGroup]];
    [groups addObject:[self fillSpecialTechniqueGroup]];
    [groups addObject:[self fillMotoTechniqueGroup]];
    [groups addObject:[self fillHydroGroup]];
    [groups addObject:[self fillCuttersAndYachtsGroup]];
    [groups addObject:[self fillBoatsGroup]];
    [groups addObject:[self fillAutopartsGroup]];
    [groups addObject:[self fillTiresGroup]];
    [groups addObject:[self fillDisksGroup]];
}

- (AdvGroup *)getMainGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Главная";
    group.type = GroupTypeMain;
    
    NSDictionary *rubrics = [AdvDictionaries Rubrics];
    AdvField *f1 = [AdvField newAdvField:F_RUBRIC_ENG :F_RUBRIC_RUS :rubrics :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_SUBRUBRIC_ENG :F_SUBRUBRIC_RUS :[AdvDictionaries RubricsWithSubrubrics] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    f2.dependentField = f1;
    f1.isExistMainField = YES;
    f1.dependentField = f2;
    
    
    NSArray *fields = @[f1, f2];
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillGeneralGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Общие поля";
    group.type = GroupTypeGeneral;
    
    AdvField *f1 = [AdvField newAdvField:F_PRICE_ENG :F_PRICE_RUS :nil :nil :nil :ValueTypeString :YES :YES :YES :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_BARGAIN_ENG :F_BARGAIN_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f3 = [AdvField newAdvField:F_CONTACT_NAME_ENG :F_CONTACT_NAME_RUS :nil :nil :nil :ValueTypeString :YES :YES :NO :NO :NO :YES];
    AdvField *f4 = [AdvField newAdvField:F_CONTACT_PHONE_ENG :F_CONTACT_PHONE_RUS :nil :nil :nil :ValueTypeString :YES :YES :NO :NO :NO :YES];
    AdvField *f5 = [AdvField newAdvField:F_ADDITIONAL_INFO_ENG :F_ADDITIONAL_INFO_RUS :nil :nil :nil :ValueTypeString :YES :NO :NO :NO :NO :NO];
    AdvField *f6 = [AdvField newAdvField:F_PHOTO_ENG :F_PHOTO_RUS :nil :nil :nil :ValueTypePhoto :YES :NO :YES :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_CITY_CODE_ENG :F_CITY_CODE_RUS :nil :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_PERIOD_ENG :F_PERIOD_RUS :[AdvDictionaries AdPeriods] :V_AD_PERIODS_8_WEEKS_RUS :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :NO];
    AdvField *f9 = [AdvField new]; // непонятно, что делать
    AdvField *f10 = [AdvField newAdvField:F_DATE_ENG :F_DATE_RUS :nil :nil :nil :ValueTypeString :NO :NO :NO :NO :YES :NO];
    AdvField *f11 = [AdvField newAdvField:nil :F_IS_RECEIVE_IMMEDIATELY_MESSAGES :[AdvDictionaries Bools] :V_YES_RUS :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :NO];
    AdvField *f12 = [AdvField newAdvField:nil :F_IS_AGREE_WITH_PLACEMENT_RULES :[AdvDictionaries Bools] :V_NO_RUS :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :NO];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillPassengerCarGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Легковые";
    group.type = GroupTypePassengerCar;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f8 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesRusForeign] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesRusForeign] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f12 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f13 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f15 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f16 = [AdvField newAdvField:F_ENGINE_TYPE_ENG :F_ENGINE_TYPE_RUS :[AdvDictionaries EngineTypes] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f17 = [AdvField newAdvField:F_COMPLECTATION_ENG :F_COMPLECTATION_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillPassengerTrailerGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Прицепы";
    group.type = GroupTypeTrailerForCar;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_DESTINY_ENG :F_DESTINY_RUS :[AdvDictionaries TrailerDestinies] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f9 = [AdvField newAdvField:F_CAPACITY_ENG :F_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillBusesGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Автобусы";
    group.type = GroupTypeBus;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f8 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesBusesSmallSpecial] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesBuses] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f12 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f13 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f15 = [AdvField newAdvField:F_VAN_VOLUME_ENG :F_VAN_VOLUME_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f16 = [AdvField newAdvField:F_SEATS_ENG :F_SEATS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f17 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f18 = [AdvField newAdvField:F_COMPLECTATION_ENG :F_COMPLECTATION_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillTrucksGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Грузовые автомобили";
    group.type = GroupTypeTruck;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f8 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesTrucks] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f11 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesTrucks] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f12 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f13 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f15 = [AdvField newAdvField:F_CAPACITY_ENG :F_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f16 = [AdvField newAdvField:F_CABIN_TYPE_ENG :F_CABIN_TYPE_RUS :[AdvDictionaries CabinTypes] :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f17 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f18 = [AdvField newAdvField:F_COMPLECTATION_ENG :F_COMPLECTATION_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillMKTGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Малый коммерческий транспорт";
    group.type = GroupTypeMKT;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f8 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesBusesSmallSpecial] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f11 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesSmall] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f12 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f13 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f15 = [AdvField newAdvField:F_VAN_VOLUME_ENG :F_VAN_VOLUME_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f16 = [AdvField newAdvField:F_SEATS_ENG :F_SEATS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f17 = [AdvField newAdvField:F_CAPACITY_ENG :F_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f18 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f19 = [AdvField newAdvField:F_COMPLECTATION_ENG :F_COMPLECTATION_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillTruckTrailerGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Грузовые прицепы и полуприцепы";
    group.type = GroupTypeTrailerForTruckCar;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesTrailers] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f9 = [AdvField newAdvField:F_CAPACITY_ENG :F_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f10 = [AdvField newAdvField:F_AXIS_COUNT_ENG :F_AXIS_COUNT_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_COMPLECTATION_ENG :F_COMPLECTATION_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillSpecialTechniqueGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Спецтехника";
    group.type = GroupTypeSpecialTechnique;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesSpecial] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :YES :YES];
    AdvField *f11 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f12 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillMotoTechniqueGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Мототехника";
    group.type = GroupTypeMotoTechnique;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesBikes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f9 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :YES :YES];
    AdvField *f11 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f12 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f13 = [AdvField newAdvField:F_COMPLECTATION_ENG :F_COMPLECTATION_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillHydroGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Гидроциклы";
    group.type = GroupTypeHydroCycle;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_TYPE_ENG :F_TYPE_ENG :[AdvDictionaries HydrosStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_MOTO_HOURS_ENG :F_MOTO_HOURS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f12 = [AdvField newAdvField:F_COMPLECTATION_ENG :F_COMPLECTATION_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillCuttersAndYachtsGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Катера и яхты";
    group.type = GroupTypeCuttersAndYachts;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_DISPLACEMENT_ENG :F_DISPLACEMENT_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :NO :YES :NO :YES];
    AdvField *f9 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f10 = [AdvField newAdvField:F_SEATS_ENG :F_SEATS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_COMPLECTATION_ENG :F_COMPLECTATION_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillBoatsGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Лодки";
    group.type = GroupTypeBoats;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries CarStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_COMPLECTATION_ENG :F_COMPLECTATION_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillAutopartsGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Автозапчасти";
    group.type = GroupTypeAutoparts;
    
    AdvField *f1 = [AdvField newAdvField:F_TYPE_ENG :F_TYPE_RUS :[AdvDictionaries RubricsForAutoparts] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :NO :NO];
    AdvField *f2 = [AdvField newAdvField:F_SUBRUBRIC_ENG :F_SUBRUBRIC_RUS :[AdvDictionaries RubricsWithSubrubrics] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    f2.dependentField = f1;
    f1.isExistMainField = YES;
    f1.dependentField = f2;
    
    AdvField *f3 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :YES :YES :NO :YES];
    AdvField *f4 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :YES :YES :NO :YES];
    AdvField *f5 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_NAME_ENG :F_NAME_RUS :nil :nil :nil :ValueTypeString :YES :YES :NO :NO :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries GearsStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillTiresGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Шины";
    group.type = GroupTypeTires;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_SEASONALITY_ENG :F_SEASONALITY_RUS :[AdvDictionaries Seasonalities] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_SPIKES_ENG :F_SPIKES_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_DIAMETER_ENG :F_DIAMETER_RUS :[AdvDictionaries WheelDiameters] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_WIDTH_ENG :F_WIDTH_RUS :[AdvDictionaries TiresWidthes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_HEIGHT_ENG :F_HEIGHT_RUS :[AdvDictionaries TiresHeights] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_HOLES_COUNT_ENG :F_HOLES_COUNT_RUS :[AdvDictionaries WheelHoleCounts] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries WaterStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillDisksGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Диски";
    group.type = GroupTypeDisks;
    
    AdvField *f1 = [AdvField newAdvField:F_TYPE_ENG :F_TYPE_ENG :[AdvDictionaries WheelTypes] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MATERIAL_ENG :F_MATERIAL_RUS :[AdvDictionaries WheelMaterials] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f3 = [AdvField newAdvField:F_DIAMETER_ENG :F_DIAMETER_RUS :[AdvDictionaries WheelDiameters] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_WHEEL_WIDTH_ENG :F_WHEEL_WIDTH_RUS :[AdvDictionaries WheelWidthes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_HOLES_COUNT_ENG :F_HOLES_COUNT_RUS :[AdvDictionaries WheelHoleCounts] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_HOLES_DIAMETER_ENG :F_HOLES_DIAMETER_RUS :[AdvDictionaries WheelHoleDiameters] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :NO :YES];
    AdvField *f7 = [AdvField newAdvField:F_SORTIE_ENG :F_SORTIE_RUS :[AdvDictionaries WheelSorties] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f8 = [AdvField newAdvField:F_COUNT_ENG :F_COUNT_RUS :[AdvDictionaries WheelHoleCounts] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f9 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries WaterStates] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10];
    
    group.fields = fields;
    
    return group;
}

@end
