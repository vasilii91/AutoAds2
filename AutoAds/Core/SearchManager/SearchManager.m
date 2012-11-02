//
//  SearchManager.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SearchManager.h"

@implementation SearchManager

static SearchManager *_sharedMySingleton = nil;


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        dataManager = [KVDataManager sharedInstance];
        groups = [NSMutableDictionary new];
    }
    
    return self;
}

+ (SearchManager *)sharedMySingleton
{
    @synchronized(self)
    {
        if (!_sharedMySingleton) {
            _sharedMySingleton = [[SearchManager alloc] init];
            [_sharedMySingleton isSmallOne:F_PRICE_ENG synonimOfBigOne:F_PRICE_MAX_ENG];
            [_sharedMySingleton fillGroups];
        }
    }
    
    return _sharedMySingleton;
}


#pragma mark - Public methods

- (AdvGroup *)findGroupByGroupType:(GroupType)groupType
{
    NSString *groupTypeString = [self keyByGroupType:groupType];
    
    for (NSString *key in [groups allKeys]) {
        if ([key isEqualToString:groupTypeString]) {
            return [groups valueForKey:key];
        }
    }
    
    return nil;
}

- (AdvGroup *)categorySearchByRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    AdvGroup *brandsGroup = [self findGroupByGroupType:GroupTypeBrands];
    AdvGroup *subrubricGroup = [self subrubricGroupByRubric:rubric subrubric:subrubric];
    AdvGroup *searchGroup = [self findGroupByGroupType:GroupTypeSearch];
    AdvGroup *generalGroup = [self findGroupByGroupType:GroupTypeGeneral];
    AdvGroup *mainGroup = [self findGroupByGroupType:GroupTypeMain];
    
    AdvGroup *result = nil;
//    if ([rubric isEqualToString:@"Диски"] == NO) {
        result = [self joinGroup:mainGroup withGroup:brandsGroup];
//    }
    result = [self joinGroup:result withGroup:generalGroup];
    result = [self joinGroup:result withGroup:subrubricGroup];
    
    AdvGroup *result2 = [self mergeLittleGroup:result withBigGroup:searchGroup];
    return result2;
}

- (AdvGroup *)categoryAddAdvertisementByRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    AdvGroup *brandsGroup = [self findGroupByGroupType:GroupTypeBrands];
    AdvGroup *subrubricGroup = [self subrubricGroupByRubric:rubric subrubric:subrubric];
    AdvGroup *addAdvertisementGroup = [self findGroupByGroupType:GroupTypeAddAdvertisement];
    AdvGroup *generalGroup = [self findGroupByGroupType:GroupTypeGeneral];
    AdvGroup *mainGroup = [self findGroupByGroupType:GroupTypeMain];
    AdvGroup *result = nil;
//    if ([rubric isEqualToString:@"Диски"] == NO) {
        result = [self joinGroup:mainGroup withGroup:brandsGroup];
//    }
    result = [self joinGroup:result withGroup:generalGroup];
    
    AdvGroup *result2 = [self mergeLittleGroup:subrubricGroup withBigGroup:addAdvertisementGroup];
    result = [self joinGroup:result withGroup:result2];
    
    for (AdvField *field in result.fields) {
        if ([field.attentionText length] == 0) {
            switch (field.valueType) {
                case ValueTypeNumber:
                case ValueTypeString:
                case ValueTypePhone:
                    field.attentionText = STANDART_ATTENTION_TEXT_FOR_TEXT_FIELD;
                    break;
                    
                case ValueTypeDictionaryFromInternet:
                case ValueTypeCheckboxDictionaryFromInternet:
                case ValueTypeDictionary:
                    field.attentionText = STANDART_ATTENTION_TEXT_FOR_DICTIONARY;
                    break;
                    
                case ValueTypeEmail:
                    field.attentionText = STANDART_ATTENTION_TEXT_FOR_EMAIL;
                    break;
                    
                default:
                    field.attentionText = STANDART_ATTENTION_TEXT_FOR_TEXT_FIELD;
                    break;
            }
        }
    }
    
    return result;
}

- (KVPair *)queryToSearch:(NSArray *)fields
{
    NSMutableString *stringQuery = [NSMutableString new];
    NSMutableString *stringQueryRussian = [NSMutableString new];
    
    for (AdvField *field in fields) {
//        if (field.isPrecondition && field.selectedValue == nil && field.valueByDefault == nil) {
//            return nil;
//        }
        NSString *fieldName = field.nameEnglish;
        KVPair *fieldValue = [self fieldValueByField:field];
        
        if ([fieldName isEqualToString:F_CITY_CODE_ENG]) {
            if ([fieldValue.queryEnglish length] != 0) {
                [stringQuery appendFormat:@"%@=%@", F_CITY_CODE_ENG, fieldValue.queryEnglish];
                [stringQueryRussian appendFormat:@"%@=%@", F_CITY_CODE_RUS, fieldValue.queryRussian];
            }
            else {
                [stringQueryRussian appendFormat:@"%@=Любой", F_CITY_CODE_RUS];
            }
        }
        else if (fieldValue.queryEnglish != nil) {
            
            NSArray *values = [fieldValue.queryEnglish componentsSeparatedByString:@","];
            for (NSString *str in values) {
                if ([stringQuery length] == 0) {
                    [stringQuery appendFormat:@"%@=%@", fieldName, str];
                }
                else {
                    [stringQuery appendFormat:@"&%@=%@", fieldName, str];
                }
            }
            
            [stringQueryRussian appendFormat:@"&%@=%@", field.nameRussian, fieldValue.queryRussian];
        }
    }
    
    KVPair *pair = [KVPair new];
    pair.queryEnglish = stringQuery;
    pair.queryRussian = stringQueryRussian;

    return pair;
}

- (NSDictionary *)parametersToAddAdvertisement:(NSArray *)fields captchaCode:(NSString *)captchaCode
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];

    for (AdvField *field in fields) {
        NSString *fieldName = field.nameEnglish;
        KVPair *fieldValue = [self fieldValueByField:field];
        
        if ([fieldName length] != 0 && [fieldValue.queryEnglish length] != 0) {
            fieldName = [[AdvDictionaries AddAdvertisementFields] valueForKey:fieldName];
            if ([fieldName length] != 0) {
                [parameters setValue:fieldValue.queryEnglish forKey:fieldName];
            }
        }
    }
    [parameters setValue:captchaCode forKey:F_CAPTCHA_CODE_ENG];
    
    return parameters;
}

- (KVPair *)fieldValueByField:(AdvField *)field
{
    NSString *fieldValue = @"";
    NSString *fieldValueRussian = @"";
    
    if (field.valueType == ValueTypeDictionary || field.valueType == ValueTypeDictionaryFromInternet) {
        fieldValue = [field.value valueForKey:field.selectedValue];
        fieldValueRussian = field.selectedValue;
    }
    else if (field.valueType == ValueTypeString ||
             field.valueType == ValueTypeNumber ||
             field.valueType == ValueTypeCaptcha ||
             field.valueType == ValueTypeEmail) {
        
        fieldValue = field.selectedValue;
        fieldValue = field.selectedValue;
    }
    
    if ([fieldValue length] == 0) {
        fieldValue = @"";
        fieldValueRussian = @"";
        id dataSource = nil;
        BOOL isOptions = NO;
        if ([field.nameEnglish isEqualToString:F_MODEL_ENG]) {
            dataSource = dataManager.selectedModels;
        }
        else if ([field.nameEnglish isEqualToString:F_FUEL_ENG]) {
            dataSource = dataManager.selectedFuels;
        }
        else if ([field.nameEnglish isEqualToString:F_STATES_ENG]) {
            dataSource = dataManager.selectedStates;
        }
        else if ([field.nameEnglish isEqualToString:F_OPTIONS_ENG]) {
            dataSource = dataManager.selectedOptions;
            isOptions = YES;
        }
        
        if ([dataSource count] != 0) {
            NSInteger index = 0;
            for (id obj in dataSource) {
                NSString *str = nil, *strRussian;
                if (isOptions) {
                    str = [NSString stringWithFormat:@"%@", ((Option *)obj).id];
                    strRussian = [NSString stringWithFormat:@"%@", ((Option *)obj).title];
                }
                else {
                    str = [field.value valueForKey:(NSString *)obj];
                    strRussian = (NSString *)obj;
                }
                if (index == 0) {
                    fieldValue = [fieldValue stringByAppendingString:str];
                    fieldValueRussian = [fieldValueRussian stringByAppendingString:strRussian];
                }
                else {
                    fieldValue = [fieldValue stringByAppendingFormat:@",%@", str];
                    fieldValueRussian = [fieldValueRussian stringByAppendingFormat:@",%@", strRussian];
                }
                index++;
            }
        }
        // у телефонов свой формат, поэтому обрабатывается отдельно
        else if ([field.nameEnglish isEqualToString:F_PHONE_ENG]) {
            NSInteger index = 0;
            for (Phone *phone in dataManager.selectedPhones) {
                if (index != 0) {
                    fieldValue = [fieldValue stringByAppendingString:@","];
                    fieldValueRussian = [fieldValueRussian stringByAppendingString:@","];
                }
                fieldValue = [fieldValue stringByAppendingFormat:@"{\"Code\":%@, \"Number\":%@, \"Extra\":%@}", phone.Code, phone.Number, phone.Extra];
                fieldValueRussian = [phone prettyPhone];
                index++;
            }
            fieldValue = [NSString stringWithFormat:@"[%@]", fieldValue];
        }
        else {
            if (field.valueType == ValueTypeDictionary || field.valueType == ValueTypeDictionaryFromInternet) {
                fieldValue = [field.value valueForKey:field.valueByDefault];
                fieldValueRussian = field.valueByDefault;
            }
            else if (field.valueType == ValueTypeString ||
                     field.valueType == ValueTypeNumber ||
                     field.valueType == ValueTypeCaptcha ||
                     field.valueType == ValueTypeEmail) {
                
                fieldValue = field.valueByDefault;
                fieldValueRussian = field.valueByDefault;
            }
        }
    }
    
    KVPair *pair = [KVPair new];
    pair.queryEnglish = fieldValue;
    pair.queryRussian = fieldValueRussian;
    
    return pair;
}


#pragma mark - Private methods

- (AdvGroup *)subrubricGroupByRubric:(NSString *)rubric subrubric:(NSString *)subrubric
{
    AdvGroup *subrubricGroup = nil;
    if ([subrubric isEqualToString:@"Отечественные авто"] ||
        [subrubric isEqualToString:@"Иномарки"]) {
        subrubricGroup = [self findGroupByGroupType:GroupTypePassengerCar];
    }
    else if ([[[AdvDictionaries SubrubricsMoto] allKeys] containsObject:subrubric]) {
        subrubricGroup = [self findGroupByGroupType:GroupTypeMotoTechnique];
    }
    else if ([rubric isEqualToString:@"Автозапчасти"]) {
        subrubricGroup = [self findGroupByGroupType:GroupTypeAutoparts];
    }
    else {
        for (AdvGroup *group in [groups allValues]) {
            if ([group.name isEqualToString:subrubric]) {
                subrubricGroup = group;
                break;
            }
        }
    }
    
    return subrubricGroup;
}

- (AdvGroup *)joinGroup:(AdvGroup *)group1 withGroup:(AdvGroup *)group2
{
    AdvGroup *joindedGroup = [AdvGroup new];
    joindedGroup.name = [NSString stringWithFormat:@"%@_joined_%@", group1.name, group2.name];
    joindedGroup.type = GroupTypeJoined;
    
    NSMutableArray *fields = [[NSMutableArray alloc] init];
    [fields addObjectsFromArray:group1.fields];
    [fields addObjectsFromArray:group2.fields];
    
    joindedGroup.fields = fields;
    
    return joindedGroup;
}

- (AdvGroup *)mergeLittleGroup:(AdvGroup *)littleGroup withBigGroup:(AdvGroup *)bigGroup
{
    AdvGroup *mergedGroup = [AdvGroup new];
    mergedGroup.name = [NSString stringWithFormat:@"%@_merged_%@", littleGroup.name, bigGroup.name];
    mergedGroup.type = GroupTypeMerged;
    
    NSMutableArray *fields = [NSMutableArray new];
    for (AdvField *bigField in bigGroup.fields) {
        for (AdvField *littleField in littleGroup.fields) {
            if ([littleField.nameEnglish isEqualToString:bigField.nameEnglish]) {
                
                // add attention text to field from small group
                littleField.attentionText = bigField.attentionText;
                
                [fields addObject:littleField];
                break;
            }
            else if ([self isSmallOne:littleField.nameEnglish synonimOfBigOne:bigField.nameEnglish] ||
                     [bigField.nameEnglish isEqualToString:F_WITH_PHOTO_ENG] ||
                     [bigField.nameEnglish isEqualToString:F_CAPTCHA_CODE_ENG] ||
                     [bigField.nameEnglish isEqualToString:F_EMAIL_ENG]) {
                [fields addObject:bigField];
                break;
            }
        }
    }
    mergedGroup.fields = fields;
    
    return mergedGroup;
}

- (NSString *)keyByGroupType:(GroupType)groupType
{
    return [NSString stringWithFormat:@"%d", groupType];
}

- (void)addGroupToGroups:(AdvGroup *)group
{
    NSString *key = [self keyByGroupType:group.type];
    [groups setValue:group forKey:key];
}

- (BOOL)isSmallOne:(NSString *)smallOne synonimOfBigOne:(NSString *)bigOne
{
    NSDictionary *synonims = [AdvDictionaries SynonimsOfFields];
    NSString *synonim = [synonims valueForKey:bigOne];
    
    if (synonim != nil && [synonim isEqualToString:smallOne]) {
        return YES;
    }
    return NO;
}

- (void)fillGroups
{
    [self addGroupToGroups:[self fillBrandsGroup]];
    [self addGroupToGroups:[self fillMainGroup]];
    [self addGroupToGroups:[self fillGeneralGroup]];
    [self addGroupToGroups:[self fillPassengerCarGroup]];
    [self addGroupToGroups:[self fillPassengerTrailerGroup]];
    [self addGroupToGroups:[self fillBusesGroup]];
    [self addGroupToGroups:[self fillTrucksGroup]];
    [self addGroupToGroups:[self fillMKTGroup]];
    [self addGroupToGroups:[self fillTruckTrailerGroup]];
    [self addGroupToGroups:[self fillSpecialTechniqueGroup]];
    [self addGroupToGroups:[self fillMotoTechniqueGroup]];
    [self addGroupToGroups:[self fillHydroGroup]];
    [self addGroupToGroups:[self fillCuttersAndYachtsGroup]];
    [self addGroupToGroups:[self fillBoatsGroup]];
    [self addGroupToGroups:[self fillAutopartsGroup]];
    [self addGroupToGroups:[self fillTiresGroup]];
    [self addGroupToGroups:[self fillDisksGroup]];
    [self addGroupToGroups:[self fillAddAdvertisementGroup]];
    [self addGroupToGroups:[self fillSearchGroup]];
}


#pragma mark - Groups

- (AdvGroup *)fillMainGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Главная";
    group.type = GroupTypeMain;
    
    AdvField *f0 = [AdvField newAdvField:F_CITY_CODE_ENG :F_CITY_CODE_RUS :[AdvDictionaries Cities] :nil :@"Любой" :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f1 = [AdvField newAdvField:F_RUBRIC_ENG :F_RUBRIC_RUS :[AdvDictionaries Rubrics] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_SUBRUBRIC_ENG :F_SUBRUBRIC_RUS :[AdvDictionaries RubricsWithSubrubrics] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    f2.dependentField = f1;
    f1.isExistMainField = YES;
    f1.dependentField = f2;
    
    
    NSArray *fields = @[f0, f1, f2];
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillBrandsGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Модели";
    group.type = GroupTypeBrands;
    
    AdvField *f1 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    
    
    NSArray *fields = @[f1, f2, f3];
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillGeneralGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Общие поля";
    group.type = GroupTypeGeneral;
    
    AdvField *f1 = [AdvField newAdvField:F_PRICE_ENG :F_PRICE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_BARGAIN_ENG :F_BARGAIN_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f3 = [AdvField newAdvField:F_CONTACTS_ENG :F_CONTACTS_RUS :nil :nil :nil :ValueTypeString :YES :YES :NO :NO :NO :YES];
    AdvField *f4 = [AdvField newAdvField:F_PHONE_ENG :F_PHONE_RUS :nil :nil :nil :ValueTypePhone :YES :YES :NO :NO :NO :YES];
    AdvField *f5 = [AdvField newAdvField:F_ADDITIONAL_INFO_ENG :F_ADDITIONAL_INFO_RUS :nil :nil :nil :ValueTypeString :YES :NO :NO :NO :NO :NO];
    AdvField *f6 = [AdvField newAdvField:F_PHOTO_ENG :F_PHOTO_RUS :nil :nil :nil :ValueTypePhoto :YES :NO :YES :YES :YES :YES];
//    AdvField *f7 = [AdvField newAdvField:F_CITY_CODE_ENG :F_CITY_CODE_RUS :nil :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_PERIOD_ENG :F_PERIOD_RUS :[AdvDictionaries AdPeriods] :V_AD_PERIODS_8_WEEKS_RUS :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :NO];
    AdvField *f9 = [AdvField new]; // непонятно, что делать
    AdvField *f10 = [AdvField newAdvField:F_DATE_ENG :F_DATE_RUS :nil :nil :nil :ValueTypeString :NO :NO :NO :NO :YES :NO];
    AdvField *f11 = [AdvField newAdvField:nil :F_IS_RECEIVE_IMMEDIATELY_MESSAGES :[AdvDictionaries Bools] :V_YES_RUS :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :NO];
    AdvField *f12 = [AdvField newAdvField:nil :F_IS_AGREE_WITH_PLACEMENT_RULES :[AdvDictionaries Bools] :V_NO_RUS :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :NO];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f8, f9, f10, f11, f12];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillPassengerCarGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Легковые";
    group.type = GroupTypePassengerCar;
    
    AdvField *f4 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f8 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesRusForeign] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesRusForeign] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f12 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f13 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f15 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f16 = [AdvField newAdvField:F_ENGINE_TYPE_ENG :F_ENGINE_TYPE_RUS :[AdvDictionaries EngineTypes] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f17 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillPassengerTrailerGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Прицепы";
    group.type = GroupTypeTrailerForCar;
    
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_DESTINY_ENG :F_DESTINY_RUS :[AdvDictionaries TrailerDestinies] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f9 = [AdvField newAdvField:F_CAPACITY_ENG :F_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillBusesGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Автобусы";
    group.type = GroupTypeBus;
    
    AdvField *f4 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f8 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesBusesSmallSpecial] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesBuses] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f12 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f13 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f15 = [AdvField newAdvField:F_VAN_VOLUME_ENG :F_VAN_VOLUME_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f16 = [AdvField newAdvField:F_SEATS_ENG :F_SEATS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f17 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f18 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillTrucksGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Грузовые автомобили";
    group.type = GroupTypeTruck;
    
    AdvField *f4 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f8 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypesTrucks] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesTrucks] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f11 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesTrucks] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f12 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f13 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f15 = [AdvField newAdvField:F_CAPACITY_ENG :F_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f16 = [AdvField newAdvField:F_CABIN_TYPE_ENG :F_CABIN_TYPE_RUS :[AdvDictionaries CabinTypes] :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f17 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f18 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillMKTGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Малый коммерческий транспорт";
    group.type = GroupTypeMKT;
    
    AdvField *f4 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f8 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypesMKT] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesBusesSmallSpecial] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f11 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesSmall] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f12 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f13 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f15 = [AdvField newAdvField:F_VAN_VOLUME_ENG :F_VAN_VOLUME_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f16 = [AdvField newAdvField:F_SEATS_ENG :F_SEATS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f17 = [AdvField newAdvField:F_CAPACITY_ENG :F_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f18 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f19 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillTruckTrailerGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Грузовые прицепы и полуприцепы";
    group.type = GroupTypeTrailerForTruckCar;
    
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesTrailers] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f9 = [AdvField newAdvField:F_CAPACITY_ENG :F_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f10 = [AdvField newAdvField:F_AXIS_COUNT_ENG :F_AXIS_COUNT_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10, f11];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillSpecialTechniqueGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Спецтехника";
    group.type = GroupTypeSpecialTechnique;
    
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesSpecial] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f11 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f12 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10, f11, f12];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillMotoTechniqueGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Мототехника";
    group.type = GroupTypeMotoTechnique;
    
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesBikes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f9 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f11 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f12 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f13 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10, f11, f12, f13];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillHydroGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Гидроциклы";
    group.type = GroupTypeHydroCycle;
    
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesWater] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_TYPE_ENG :F_TYPE_ENG :[AdvDictionaries HydrosTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_MOTO_HOURS_ENG :F_MOTO_HOURS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f12 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10, f11, f12];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillCuttersAndYachtsGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Катера и яхты";
    group.type = GroupTypeCuttersAndYachts;
    
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesWater] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_DISPLACEMENT_ENG :F_DISPLACEMENT_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :NO :YES :NO :YES];
    AdvField *f9 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f10 = [AdvField newAdvField:F_SEATS_ENG :F_SEATS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10, f11];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillBoatsGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Лодки";
    group.type = GroupTypeBoats;
    
    AdvField *f4 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesWater] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f7 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillAutopartsGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Автозапчасти";
    group.type = GroupTypeAutoparts;
    
    AdvField *f1 = [AdvField newAdvField:F_I_RAZDEL_ENG :F_I_RAZDEL_RUS :[AdvDictionaries RubricsForAutoparts] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :NO :NO];
    AdvField *f2 = [AdvField newAdvField:F_RUBRICID_ENG :F_RUBRICID_RUS :[AdvDictionaries RubricsWithSubrubrics] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    f2.dependentField = f1;
    f1.isExistMainField = YES;
    f1.dependentField = f2;
    
    AdvField *f6 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_NAME_ENG :F_NAME_RUS :nil :nil :nil :ValueTypeString :YES :YES :NO :NO :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesGears] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    
    NSArray *fields = @[f1, f2, f6, f7, f8];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillTiresGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Шины";
    group.type = GroupTypeTires;
    
    AdvField *f4 = [AdvField newAdvField:F_SEASONALITY_ENG :F_SEASONALITY_RUS :[AdvDictionaries Seasonalities] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_SPIKES_ENG :F_SPIKES_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :YES];
    AdvField *f6 = [AdvField newAdvField:F_DIAMETER_ENG :F_DIAMETER_RUS :[AdvDictionaries WheelDiameters] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_WIDTH_ENG :F_WIDTH_RUS :[AdvDictionaries TiresWidthes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_HEIGHT_ENG :F_HEIGHT_RUS :[AdvDictionaries TiresHeights] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_HOLES_COUNT_ENG :F_HOLES_COUNT_RUS :[AdvDictionaries WheelHoleCounts] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesWater] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    
    NSArray *fields = @[f4, f5, f6, f7, f8, f9, f10];
    
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
    AdvField *f10 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesWater] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillAddAdvertisementGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Добавить объявление";
    group.type = GroupTypeAddAdvertisement;
    
    AdvField *f1 = [AdvField newAdvField:F_RUBRIC_ENG :F_RUBRIC_RUS :[AdvDictionaries Rubrics] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_SUBRUBRIC_ENG :F_SUBRUBRIC_RUS :[AdvDictionaries RubricsWithSubrubrics] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_MODIFICATION_ENG :F_MODIFICATION_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :NO :NO :NO :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_YEAR_ENG :F_YEAR_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_MILEAGE_ENG :F_MILEAGE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_COLOR_ENG :F_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_INTERNAL_COLOR_ENG :F_INTERNAL_COLOR_RUS :[AdvDictionaries VehicleColors] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :YES :YES];
    AdvField *f10 = [AdvField newAdvField:F_METALLIC_ENG :F_METALLIC_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f12 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f13 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesBusesSmallSpecial] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesSmall] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f15 = [AdvField newAdvField:F_STATUS_ENG :F_STATUS_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f16 = [AdvField newAdvField:F_ENGINE_CAPACITY_ENG :F_ENGINE_CAPACITY_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f17 = [AdvField newAdvField:F_ENGINE_POWER_ENG :F_ENGINE_POWER_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f18 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f19 = [AdvField newAdvField:F_ENGINE_TYPE_ENG :F_ENGINE_TYPE_RUS :[AdvDictionaries EngineTypes] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f20 = [AdvField newAdvField:F_DESTINY_ENG :F_DESTINY_RUS :[AdvDictionaries TrailerDestinies] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f21 = [AdvField newAdvField:F_CAPACITY_ENG :F_CAPACITY_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f22 = [AdvField newAdvField:F_VAN_VOLUME_ENG :F_VAN_VOLUME_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f23 = [AdvField newAdvField:F_SEATS_ENG :F_SEATS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f24 = [AdvField newAdvField:F_CABIN_TYPE_ENG :F_CABIN_TYPE_RUS :[AdvDictionaries CabinTypes] :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f25 = [AdvField newAdvField:F_AXIS_COUNT_ENG :F_AXIS_COUNT_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f26 = [AdvField newAdvField:F_MOTO_HOURS_ENG :F_MOTO_HOURS_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :NO :NO :YES];
    AdvField *f27 = [AdvField newAdvField:F_DISPLACEMENT_ENG :F_DISPLACEMENT_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :NO :YES :NO :YES];
    AdvField *f28 = [AdvField newAdvField:F_NAME_ENG :F_NAME_RUS :nil :nil :nil :ValueTypeString :YES :YES :NO :NO :YES :YES];
    AdvField *f29 = [AdvField newAdvField:F_SEASONALITY_ENG :F_SEASONALITY_RUS :[AdvDictionaries Seasonalities] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f30 = [AdvField newAdvField:F_SPIKES_ENG :F_SPIKES_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :YES];
    AdvField *f31 = [AdvField newAdvField:F_DIAMETER_ENG :F_DIAMETER_RUS :[AdvDictionaries WheelDiameters] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f32 = [AdvField newAdvField:F_WHEEL_WIDTH_ENG :F_WHEEL_WIDTH_RUS :[AdvDictionaries WheelWidthes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f33 = [AdvField newAdvField:F_WIDTH_ENG :F_WIDTH_RUS :[AdvDictionaries TiresWidthes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f34 = [AdvField newAdvField:F_HEIGHT_ENG :F_HEIGHT_RUS :[AdvDictionaries TiresHeights] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f35 = [AdvField newAdvField:F_COUNT_ENG :F_COUNT_RUS :[AdvDictionaries WheelHoleCounts] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f36 = [AdvField newAdvField:F_TYPE_ENG :F_TYPE_ENG :[AdvDictionaries WheelTypes] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f37 = [AdvField newAdvField:F_MATERIAL_ENG :F_MATERIAL_RUS :[AdvDictionaries WheelMaterials] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f38 = [AdvField newAdvField:F_HOLES_COUNT_ENG :F_HOLES_COUNT_RUS :[AdvDictionaries WheelHoleCounts] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :NO :YES];
    AdvField *f39 = [AdvField newAdvField:F_HOLES_DIAMETER_ENG :F_HOLES_DIAMETER_RUS :[AdvDictionaries WheelHoleDiameters] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :NO :YES];
    AdvField *f40 = [AdvField newAdvField:F_SORTIE_ENG :F_SORTIE_RUS :[AdvDictionaries WheelSorties] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f41 = [AdvField newAdvField:F_OPTIONS_ENG :F_OPTIONS_RUS :nil :nil :nil :ValueTypeCheckboxDictionaryFromInternet :YES :NO :NO :NO :NO :YES];
    AdvField *f42 = [AdvField newAdvField:F_PRICE_ENG :F_PRICE_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f43 = [AdvField newAdvField:F_BARGAIN_ENG :F_BARGAIN_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f44 = [AdvField newAdvField:F_CONTACTS_ENG :F_CONTACTS_RUS :nil :nil :nil :ValueTypeString :YES :YES :NO :NO :NO :YES];
    AdvField *f45 = [AdvField newAdvField:F_PHONE_ENG :F_PHONE_RUS :nil :nil :nil :ValueTypePhone :YES :YES :NO :NO :NO :YES];
    AdvField *f46 = [AdvField newAdvField:F_EMAIL_ENG :F_EMAIL_RUS :nil :nil :nil :ValueTypeEmail :YES :YES :YES :NO :NO :NO];
    AdvField *f47 = [AdvField newAdvField:F_ADDITIONAL_INFO_ENG :F_ADDITIONAL_INFO_RUS :nil :nil :nil :ValueTypeString :YES :NO :NO :NO :NO :NO];
    AdvField *f48 = [AdvField newAdvField:F_PERIOD_ENG :F_PERIOD_RUS :[AdvDictionaries AdPeriods] :V_AD_PERIODS_8_WEEKS_RUS :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :NO];
//    AdvField *f49 = [AdvField newAdvField:F_CITY_CODE_ENG :F_CITY_CODE_RUS :nil :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f50 = [AdvField newAdvField:F_PHOTO_ENG :F_PHOTO_RUS :nil :nil :nil :ValueTypePhoto :YES :NO :YES :YES :YES :YES];
    AdvField *f51 = [AdvField newAdvField:F_NUMBER_OF_OWNERS_ENG :F_NUMBER_OF_OWNERS_RUS :nil :nil :nil :ValueTypeString :YES :NO :NO :NO :NO :NO];
    AdvField *f52 = [AdvField newAdvField:F_VIN_ENG :F_VIN_RUS :nil :nil :nil :ValueTypeString :YES :NO :NO :NO :NO :NO];
    AdvField *f53 = [AdvField newAdvField:F_FROM_OFFICIAL_DEALER_ENG :F_FROM_OFFICIAL_DEALER_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
//    AdvField *f54 = [AdvField newAdvField:F_CAPTCHA_CODE_ENG :F_CAPTCHA_CODE_RUS :nil :nil :nil :ValueTypeCaptcha :YES :YES :YES :NO :NO :NO];
    
    NSArray *fields = @[f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f50, f51, f52, f53];
    
    group.fields = fields;
    
    return group;
}

- (AdvGroup *)fillSearchGroup
{
    AdvGroup *group = [AdvGroup new];
    group.name = @"Поиск";
    group.type = GroupTypeSearch;
    
    AdvField *f0 = [AdvField newAdvField:F_CITY_CODE_ENG :F_CITY_CODE_RUS :nil :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f1 = [AdvField newAdvField:F_RUBRIC_ENG :F_RUBRIC_RUS :[AdvDictionaries Rubrics] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f2 = [AdvField newAdvField:F_SUBRUBRIC_ENG :F_SUBRUBRIC_RUS :[AdvDictionaries RubricsWithSubrubrics] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f3 = [AdvField newAdvField:F_BRAND_ENG :F_BRAND_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f4 = [AdvField newAdvField:F_MODEL_ENG :F_MODEL_RUS :nil :nil :nil :ValueTypeDictionaryFromInternet :YES :YES :NO :YES :YES :YES];
    AdvField *f5 = [AdvField newAdvField:F_PRICE_MAX_ENG :F_PRICE_MAX_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f6 = [AdvField newAdvField:F_PRICE_MIN_ENG :F_PRICE_MIN_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f7 = [AdvField newAdvField:F_MILEAGE_MAX_ENG :F_MILEAGE_MAX_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f8 = [AdvField newAdvField:F_MILEAGE_MIN_ENG :F_MILEAGE_MIN_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :YES :YES :YES :YES];
    AdvField *f9 = [AdvField newAdvField:F_ENGINE_POWER_MAX_ENG :F_ENGINE_POWER_MAX_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f10 = [AdvField newAdvField:F_ENGINE_POWER_MIN_ENG :F_ENGINE_POWER_MIN_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f11 = [AdvField newAdvField:F_YEAR_MAX_ENG :F_YEAR_MAX_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f12 = [AdvField newAdvField:F_YEAR_MIN_ENG :F_YEAR_MIN_RUS :[AdvDictionaries Years] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f13 = [AdvField newAdvField:F_ENGINE_CAPACITY_MAX_ENG :F_ENGINE_CAPACITY_MAX_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f14 = [AdvField newAdvField:F_ENGINE_CAPACITY_MIN_ENG :F_ENGINE_CAPACITY_MIN_RUS :[AdvDictionaries EngineCapacities] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f15 = [AdvField newAdvField:F_DRIVE_ENG :F_DRIVE_RUS :[AdvDictionaries DriveTypesBusesSmallSpecial] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f16 = [AdvField newAdvField:F_BODY_TYPE_ENG :F_BODY_TYPE_RUS :[AdvDictionaries BodyTypesSmall] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f17 = [AdvField newAdvField:F_ENGINE_TYPE_ENG :F_ENGINE_TYPE_RUS :[AdvDictionaries EngineTypes] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :YES :YES];
    AdvField *f18 = [AdvField newAdvField:F_GEARBOX_ENG :F_GEARBOX_RUS :[AdvDictionaries GearboxTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f19 = [AdvField newAdvField:F_RUDDER_ENG :F_RUDDER_RUS :[AdvDictionaries Rudder] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f20 = [AdvField newAdvField:F_FUEL_ENG :F_FUEL_RUS :[AdvDictionaries FuelTypes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f21 = [AdvField newAdvField:F_STATES_ENG :F_STATES_RUS :[AdvDictionaries StatesCar] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f22 = [AdvField newAdvField:F_PERIOD_ENG :F_PERIOD_RUS :[AdvDictionaries AdPeriods] :V_AD_PERIODS_8_WEEKS_RUS :nil :ValueTypeDictionary :YES :YES :NO :NO :NO :NO];
    AdvField *f24 = [AdvField newAdvField:F_WITH_PHOTO_ENG :F_WITH_PHOTO_RUS :[AdvDictionaries Bools] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f25 = [AdvField newAdvField:F_DESTINY_ENG :F_DESTINY_RUS :[AdvDictionaries TrailerDestinies] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f26 = [AdvField newAdvField:F_TYPE_ENG :F_TYPE_ENG :[AdvDictionaries WheelTypes] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f27 = [AdvField newAdvField:F_SEATS_MAX_ENG :F_SEATS_MAX_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f28 = [AdvField newAdvField:F_SEATS_MIN_ENG :F_SEATS_MIN_RUS :nil :nil :nil :ValueTypeNumber :YES :NO :NO :YES :NO :YES];
    AdvField *f29 = [AdvField newAdvField:F_DISPLACEMENT_MAX_ENG :F_DISPLACEMENT_MAX_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :NO :YES :NO :YES];
    AdvField *f30 = [AdvField newAdvField:F_DISPLACEMENT_MIN_ENG :F_DISPLACEMENT_MIN_RUS :nil :nil :nil :ValueTypeNumber :YES :YES :NO :YES :NO :YES];
    AdvField *f31 = [AdvField newAdvField:F_I_RAZDEL_ENG :F_I_RAZDEL_RUS :[AdvDictionaries RubricsForAutoparts] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :NO :NO];
    AdvField *f32 = [AdvField newAdvField:F_RUBRICID_ENG :F_RUBRICID_RUS :[AdvDictionaries RubricsWithSubrubrics] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f33 = [AdvField newAdvField:F_SEASONALITY_ENG :F_SEASONALITY_RUS :[AdvDictionaries Seasonalities] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f34 = [AdvField newAdvField:F_DIAMETER_MAX_ENG :F_DIAMETER_MAX_RUS :[AdvDictionaries WheelDiameters] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f35 = [AdvField newAdvField:F_DIAMETER_MIN_ENG :F_DIAMETER_MIN_RUS :[AdvDictionaries WheelDiameters] :nil :nil :ValueTypeDictionary :YES :YES :YES :YES :YES :YES];
    AdvField *f36 = [AdvField newAdvField:F_WIDTH_MAX_ENG :F_WIDTH_MAX_RUS :[AdvDictionaries TiresWidthes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f37 = [AdvField newAdvField:F_WIDTH_MIN_ENG :F_WIDTH_MIN_RUS :[AdvDictionaries TiresWidthes] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f38 = [AdvField newAdvField:F_HEIGHT_MAX_ENG :F_HEIGHT_MAX_RUS :[AdvDictionaries TiresHeights] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f39 = [AdvField newAdvField:F_HEIGHT_MIN_ENG :F_HEIGHT_MIN_RUS :[AdvDictionaries TiresHeights] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :YES :YES];
    AdvField *f40 = [AdvField newAdvField:F_MATERIAL_ENG :F_MATERIAL_RUS :[AdvDictionaries WheelMaterials] :nil :nil :ValueTypeDictionary :YES :YES :NO :YES :NO :YES];
    AdvField *f41 = [AdvField newAdvField:F_SORTIE_ENG :F_SORTIE_RUS :[AdvDictionaries WheelSorties] :nil :nil :ValueTypeDictionary :YES :NO :NO :NO :NO :YES];
    AdvField *f42 = [AdvField newAdvField:F_HOLES_DIAMETER_MAX_ENG :F_HOLES_DIAMETER_MAX_RUS :[AdvDictionaries WheelHoleDiameters] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :NO :YES];
    AdvField *f43 = [AdvField newAdvField:F_HOLES_DIAMETER_MIN_ENG :F_HOLES_DIAMETER_MIN_RUS :[AdvDictionaries WheelHoleDiameters] :nil :nil :ValueTypeDictionary :YES :NO :NO :YES :NO :YES];
    
    NSArray *fields = @[f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43];
    
    group.fields = fields;
    
    return group;
}

@end
