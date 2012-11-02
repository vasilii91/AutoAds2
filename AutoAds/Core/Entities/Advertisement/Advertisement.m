//
//  Advertisement.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "Advertisement.h"

@implementation Advertisement
@synthesize EngineCapacity = _EngineCapacity;
@synthesize Gearbox = _Gearbox;
@synthesize Rudder = _Rudder;
@synthesize BodyType = _BodyType;
@synthesize Drive = _Drive;
@synthesize EngineType = _EngineType;
@synthesize EnginePower = _EnginePower;
@synthesize Fuel = _Fuel;
@synthesize Status = _Status;
@synthesize Color = _Color;
@synthesize Metalic = _Metalic;
@synthesize Destiny = _Destiny;


#pragma mark - Private methods

+ (Class)Photo_class
{
    return [PhotoContainer class];
}

+ (Class)Options_class
{
    return [NSArray class];
}

- (NSString *)appendFormat:(NSString *)format toString:(NSMutableString *)str withParameter:(NSString *)parameter
{
    NSMutableString *result = str;
    if (parameter != nil) {
        if (format == nil) {
            [str appendFormat:@"%@", parameter];
        }
        else if ([parameter intValue] != 0) {
            [str appendFormat:format, parameter];
        }
    }
    
    return result;
}


#pragma mark - Setters

- (void)setRudder:(NSString *)Rudder
{
    _Rudder = [NSString stringWithFormat:@"%@", Rudder];
}

- (void)setGearbox:(NSString *)Gearbox
{
    _Gearbox = [NSString stringWithFormat:@"%@", Gearbox];
}

- (void)setBodyType:(NSString *)BodyType
{
    _BodyType = [NSString stringWithFormat:@"%@", BodyType];
}

- (void)setCapacity:(NSString *)Capacity
{
    _Capacity = [NSString stringWithFormat:@"%.0f", ([Capacity floatValue] / 1000)];
}

- (void)setPrice:(NSString *)Price
{
    _Price = [NSString stringWithFormat:@"%.0f", [Price floatValue]];
}

- (void)setEngineCapacity:(NSString *)EngineCapacity
{
    _EngineCapacity = [NSString stringWithFormat:@"%.1f", [EngineCapacity floatValue]];
}

- (void)setType:(NSString *)Type
{
    _Type = [NSString stringWithFormat:@"%@", Type];
}

- (void)setDiameter:(NSString *)Diameter
{
    _Diameter = [NSString stringWithFormat:@"%@", Diameter];
}

- (void)setWheelWidth:(NSString *)WheelWidth
{
    _WheelWidth = [NSString stringWithFormat:@"%@", WheelWidth];
}

- (void)setHeight:(NSString *)Height
{
    _Height = [NSString stringWithFormat:@"%@", Height];
}

- (void)setWidth:(NSString *)Width
{
    _Width = [NSString stringWithFormat:@"%@", Width];
}

- (void)setSeasonality:(NSString *)Seasonality
{
    _Seasonality = [NSString stringWithFormat:@"%@", Seasonality];
}

- (void)setDrive:(NSString *)Drive
{
    _Drive = [NSString stringWithFormat:@"%@", Drive];
}

- (void)setEngineType:(NSString *)EngineType
{
    _EngineType = [NSString stringWithFormat:@"%@", EngineType];
}

- (void)setEnginePower:(NSString *)EnginePower
{
    _EnginePower = [NSString stringWithFormat:@"%@", EnginePower];
}

- (void)setFuel:(NSString *)Fuel
{
    _Fuel = [NSString stringWithFormat:@"%@", Fuel];
}

- (void)setStatus:(NSString *)Status
{
    _Status = [NSString stringWithFormat:@"%@", Status];
}

- (void)setColor:(NSString *)Color
{
    _Color = [NSString stringWithFormat:@"%@", Color];
}

- (void)setMetalic:(NSString *)Metalic
{
    _Metalic = [NSString stringWithFormat:@"%@", Metalic];
}

- (void)setDestiny:(NSString *)Destiny
{
    _Destiny = [NSString stringWithFormat:@"%@", Destiny];
}



#pragma mark - Getters

- (NSString *)Year
{
    return _Year == nil ? nil : [NSString stringWithFormat:@"%@ г.", _Year];
}

- (NSString *)Mileage
{
    return _Mileage == nil ? nil : [NSString stringWithFormat:@"%@ км.", _Mileage];
}

- (NSString *)EngineCapacity
{
    return _EngineCapacity == nil ? nil : [NSString stringWithFormat:@"%@ л.", _EngineCapacity];
}

- (NSString *)EnginePower
{
    return _EnginePower == nil ? nil : [NSString stringWithFormat:@"%@ л/с", _EnginePower];
}

- (NSString *)Gearbox
{
    NSString *subrubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_SUBRUBRIC];
    
    NSDictionary *source = nil;
    if ([subrubric isEqualToString:V_RUBRIC_COMMERCIAL_TRUCKS]) {
        source = [AdvDictionaries GearboxTypesTrucks];
    }
    else if ([subrubric isEqualToString:V_RUBRIC_COMMERCIAL_SMALL]) {
        source = [AdvDictionaries GearboxTypesMKT];
    }
    else {
        source = [AdvDictionaries GearboxTypes];
    }
    return [AdvDictionaries valueFromDictionary:source forKeyOrValue: _Gearbox];
}

- (NSString *)Rudder
{
    return [AdvDictionaries valueFromDictionary:[AdvDictionaries Rudder] forKeyOrValue:_Rudder];
}

- (NSString *)Drive
{
    NSString *subrubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_SUBRUBRIC];
    
    NSDictionary *source = nil;
    if ([subrubric isEqualToString:V_RUBRIC_COMMERCIAL_BUSES] ||
        [subrubric isEqualToString:V_RUBRIC_COMMERCIAL_SMALL] ||
        [subrubric isEqualToString:V_RUBRIC_COMMERCIAL_SPECIAL]) {
        source = [AdvDictionaries DriveTypesBusesSmallSpecial];
    }
    else if ([subrubric isEqualToString:V_RUBRIC_MOTORS_RUS] ||
             [subrubric isEqualToString:V_RUBRIC_MOTORS_FOREIGN]) {
        source = [AdvDictionaries DriveTypesRusForeign];
    }
    else if ([subrubric isEqualToString:V_RUBRIC_COMMERCIAL_TRUCKS]) {
        source = [AdvDictionaries DriveTypesTrucks];
    }
    
    return [AdvDictionaries valueFromDictionary:source forKeyOrValue: _Drive];
}

- (NSString *)EngineType
{
    return [AdvDictionaries valueFromDictionary:[AdvDictionaries EngineTypes] forKeyOrValue:_EngineType];
}

- (NSString *)Fuel
{
    return [AdvDictionaries valueFromDictionary:[AdvDictionaries FuelTypes] forKeyOrValue:_Fuel];
}

- (NSString *)BodyType
{
    NSString *subrubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_SUBRUBRIC];
    
    NSDictionary *source = nil;
    if ([subrubric isEqualToString:V_RUBRIC_MOTORS_FOREIGN] ||
        [subrubric isEqualToString:V_RUBRIC_MOTORS_RUS]) {
        source = [AdvDictionaries BodyTypesRusForeign];
    }
    else if ([subrubric isEqualToString:V_RUBRIC_MOTORS_TRAILERS]) {
        source = [AdvDictionaries BodyTypesTrailers];
    }
    else if ([subrubric isEqualToString:V_RUBRIC_COMMERCIAL_SMALL]) {
        source = [AdvDictionaries BodyTypesSmall];
    }
    else if ([subrubric isEqualToString:V_RUBRIC_COMMERCIAL_SPECIAL]) {
        source = [AdvDictionaries BodyTypesSpecial];
    }
    else if ([subrubric isEqualToString:V_RUBRIC_COMMERCIAL_TRUCKS]) {
        source = [AdvDictionaries BodyTypesTrucks];
    }
    else if ([subrubric isEqualToString:V_RUBRIC_MOTO_BIKES]) {
        source = [AdvDictionaries BodyTypesBikes];
    }
    else if ([subrubric isEqualToString:V_RUBRIC_COMMERCIAL_BUSES]) {
        source = [AdvDictionaries BodyTypesBuses];
    }
    
    return [AdvDictionaries valueFromDictionary:source forKeyOrValue:_BodyType];
}

- (NSString *)Status
{
    NSString *rubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_RUBRIC];
    
    NSDictionary *source = nil;
    if ([rubric isEqualToString:V_RUBRIC_GEARS]) {
        source = [AdvDictionaries StatesGears];
    }
    else if ([rubric isEqualToString:V_RUBRIC_WATER]) {
        source = [AdvDictionaries StatesWater];
    }
    else {
        source = [AdvDictionaries StatesCar];
    }
    return [AdvDictionaries valueFromDictionary:source forKeyOrValue:_Status];
}

- (NSString *)Color
{
    return [AdvDictionaries valueFromDictionary:[AdvDictionaries VehicleColors] forKeyOrValue:_Color];
}

- (NSString *)Metalic
{
    return [AdvDictionaries valueFromDictionary:[AdvDictionaries Bools] forKeyOrValue:_Metalic];
}

- (NSString *)Destiny
{
    return [AdvDictionaries valueFromDictionary:[AdvDictionaries TrailerDestinies] forKeyOrValue:_Destiny];
}

- (NSString *)DateCreate
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_DateCreate doubleValue]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterShortStyle];
    NSString *string = [format stringFromDate:date];
    
    return string;
}

- (NSArray *)Options
{
    NSString *rubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_RUBRIC];
    NSString *subrubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_SUBRUBRIC];
    DatabaseManager *databaseManager = [DatabaseManager sharedMySingleton];
    NSMutableArray *optionCategories = [databaseManager optionCategoriesByRubric:rubric subrubric:subrubric];
    
    NSMutableArray *newOptionCategories = [NSMutableArray new];
    for (OptionsCategory *optionCategory in optionCategories) {
        
        NSMutableArray *newOptions = [NSMutableArray new];
        for (Option *option in optionCategory.fields) {
            for (NSString *optionId in _Options) {
                if ([option.id integerValue] == [optionId integerValue]) {
                    [newOptions addObject:option];
                    break;
                }
            }
        }
        
        if ([newOptions count] != 0) {
            OptionsCategory *category = [OptionsCategory new];
            category.title = optionCategory.title;
            category.fields = newOptions;
            [newOptionCategories addObject:category];
        }
    }
    
    return newOptionCategories;
}


#pragma mark - Public methods

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
    [self appendFormat:@"%@ г." toString:carOtherInfo withParameter:_Year];
    [self appendFormat:@", %@ км." toString:carOtherInfo withParameter:_Mileage];
    [self appendFormat:@", %@" toString:carOtherInfo withParameter:_Type];
    
    return carOtherInfo;
}

- (NSString *)getNameAndCity
{
    NSMutableString *nameAndCity = [NSMutableString new];
    [self appendFormat:nil toString:nameAndCity withParameter:_Contacts];
    if (_CityCode != nil) {
        NSString *cityName = [AdvDictionaries valueFromDictionary:[AdvDictionaries Cities] forKeyOrValue:_CityCode];
        [self appendFormat:@", %@" toString:nameAndCity withParameter:cityName];
    }
    if (_Chaffer != nil) {
        NSString *isChaffer = [AdvDictionaries valueFromDictionary:[AdvDictionaries Bools] forKeyOrValue:_Chaffer];
        [self appendFormat:@", возможность торга - " toString:nameAndCity withParameter:isChaffer];
    }
    return nameAndCity;
}

- (NSString *)getAdvertisementInfo
{
    NSString *rubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_RUBRIC];
    NSString *subrubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_SUBRUBRIC];
    
    NSMutableString *result = [NSMutableString new];
    
    if (rubric != nil) {
        if ([rubric isEqualToString:@"motors"]) {
            [self appendFormat:@"%@ р." toString:result withParameter:_Price];
            [self appendFormat:@", %@ г." toString:result withParameter:_Year];
            
            if ([subrubric isEqualToString:@"rus"] ||
                [subrubric isEqualToString:@"foreign"]) {
                [self appendFormat:@", %@ км." toString:result withParameter:_Mileage];
                [self appendFormat:@", %@ л." toString:result withParameter:_EngineCapacity];
                [self appendFormat:@", %@ л/c" toString:result withParameter:_EnginePower];
                
                NSString *gearboxName = [AdvDictionaries valueFromDictionary:[AdvDictionaries GearboxTypes] forKeyOrValue:_Gearbox];
                [self appendFormat:@", %@" toString:result withParameter:gearboxName];
                
                NSString *rudderName = [AdvDictionaries valueFromDictionary:[AdvDictionaries Rudder] forKeyOrValue:_Rudder];
                [self appendFormat:@", %@" toString:result withParameter:rudderName];
            }
            else if ([subrubric isEqualToString:@"trailers"]) {
                [self appendFormat:@", %@ т." toString:result withParameter:_Capacity];
            }
        }
        else if ([rubric isEqualToString:@"commercial"]) {
            [self appendFormat:@"%@ р." toString:result withParameter:_Price];
            [self appendFormat:@", %@ г." toString:result withParameter:_Year];
            
            if ([subrubric isEqualToString:@"trailers"]) {
                [self appendFormat:@", %@ т." toString:result withParameter:_Capacity];
            }
            else if ([subrubric isEqualToString:@"special"]) {
                NSString *bodyTypeName = [AdvDictionaries valueFromDictionary:[AdvDictionaries BodyTypesSpecial] forKeyOrValue:_BodyType];
                [self appendFormat:@", %@" toString:result withParameter:bodyTypeName];
            }
            else {
                [self appendFormat:@", %@ км." toString:result withParameter:_Mileage];
                [self appendFormat:@", %@ л." toString:result withParameter:_EngineCapacity];
                [self appendFormat:@", %@ л/c" toString:result withParameter:_EnginePower];
                
                NSString *gearboxName = [AdvDictionaries valueFromDictionary:[AdvDictionaries GearboxTypesMKT] forKeyOrValue:_Gearbox];
                [self appendFormat:@", %@" toString:result withParameter:gearboxName];
                
                NSString *rudderName = [AdvDictionaries valueFromDictionary:[AdvDictionaries Rudder] forKeyOrValue:_Rudder];
                [self appendFormat:@", %@" toString:result withParameter:rudderName];
            }
        }
        else if ([rubric isEqualToString:@"moto"]) {
            [self appendFormat:@"%@ р." toString:result withParameter:_Price];
            [self appendFormat:@", %@ г." toString:result withParameter:_Year];
            [self appendFormat:@", %@ км." toString:result withParameter:_Mileage];
            [self appendFormat:@", %@ л." toString:result withParameter:_EngineCapacity];
            [self appendFormat:@", %@ л/c" toString:result withParameter:_EnginePower];
        }
        else if ([rubric isEqualToString:@"water"]) {
            [self appendFormat:@"%@ р." toString:result withParameter:_Price];
            [self appendFormat:@", %@ г." toString:result withParameter:_Year];
            
            if ([subrubric isEqualToString:@"hydros"]) {
                [self appendFormat:@", %@ ч." toString:result withParameter:_MotoHours];
                [self appendFormat:@", %@ л." toString:result withParameter:_EngineCapacity];
                [self appendFormat:@", %@ л/c" toString:result withParameter:_EnginePower];
            }
            else if ([subrubric isEqualToString:@"yachts"]) {
                [self appendFormat:@", %@ л/c" toString:result withParameter:_EnginePower];
                [self appendFormat:@", мест - %@" toString:result withParameter:_Seats];
            }
            else if ([subrubric isEqualToString:@"boats"]) {
                
            }
        }
        else if ([rubric isEqualToString:@"gears"]) {
            if ([subrubric isEqualToString:@"wheels"]) {
                [self appendFormat:@"%@ р." toString:result withParameter:_Price];
                [self appendFormat:@", тип - %@" toString:result withParameter:_Type];
                [self appendFormat:@", диаметр - %@" toString:result withParameter:_Diameter];
                [self appendFormat:@", ширина - %@" toString:result withParameter:_WheelWidth];
            }
            else if ([subrubric isEqualToString:@"tires"]) {
                [self appendFormat:@"%@ р." toString:result withParameter:_Price];
                
                NSString *seasonalityName = [AdvDictionaries valueFromDictionary:[AdvDictionaries Seasonalities] forKeyOrValue:_Seasonality];
                [self appendFormat:@", сезонность - %@" toString:result withParameter:seasonalityName];
                [self appendFormat:@", диаметр - %@" toString:result withParameter:_Diameter];
                [self appendFormat:@", высота - %@" toString:result withParameter:_Height];
                [self appendFormat:@", ширина - %@" toString:result withParameter:_Width];
            }
        }
        else if ([rubric isEqualToString:@"parts"]) {
            
        }
    }
    
    return result;
}

- (NSDictionary *)getAdvertisementKeyValues
{
    NSString *rubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_RUBRIC];
    NSString *subrubric = [[NSUserDefaults standardUserDefaults] valueForKey:CURRENT_SUBRUBRIC];
    
    OrderedDictionary *keyValues = [OrderedDictionary new];
    
    [keyValues setValue:self.DateCreate forKey:@"Дата размещения"];
    
    if (rubric != nil) {
        if ([rubric isEqualToString:@"motors"]) {
            if ([subrubric isEqualToString:@"rus"] ||
                [subrubric isEqualToString:@"foreign"]) {
                
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
                [keyValues setValue:self.Mileage forKey:@"Пробег:"];
                [keyValues setValue:self.EngineCapacity forKey:@"Объём двигателя:"];
                [keyValues setValue:self.EnginePower forKey:@"Мощность:"];
                [keyValues setValue:self.Gearbox forKey:@"Коробка передач:"];
                [keyValues setValue:self.Rudder forKey:@"Тип руля:"];
                [keyValues setValue:self.Drive forKey:@"Тип привода:"];
                [keyValues setValue:self.EngineType forKey:@"Тип двигателя:"];
                [keyValues setValue:self.Fuel forKey:@"Топливо:"];
                [keyValues setValue:self.BodyType forKey:@"Тип кузова:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
                [keyValues setValue:self.Color forKey:@"Цвет кузова:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
            }
            else if ([subrubric isEqualToString:@"trailers"]) {
                
                [keyValues setValue:self.Color forKey:@"Цвет кузова:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
                [keyValues setValue:self.Destiny forKey:@"Назначение:"];
                [keyValues setValue:self.Capacity forKey:@"Грузоподъемность:"];
            }
        }
        else if ([rubric isEqualToString:@"commercial"]) {
            if ([subrubric isEqualToString:@"buses"]) {
                
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
                [keyValues setValue:self.Mileage forKey:@"Пробег:"];
                [keyValues setValue:self.Color forKey:@"Цвет:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
                [keyValues setValue:self.Rudder forKey:@"Тип руля:"];
                [keyValues setValue:self.Gearbox forKey:@"Коробка передач:"];
                [keyValues setValue:self.Drive forKey:@"Тип привода:"];
                [keyValues setValue:self.BodyType forKey:@"Тип кузова:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
                [keyValues setValue:self.EngineCapacity forKey:@"Объём двигателя:"];
                [keyValues setValue:self.EnginePower forKey:@"Мощность:"];
                [keyValues setValue:self.VanVolume forKey:@"Объем фургона:"];
                [keyValues setValue:self.Seats forKey:@"Число мест:"];
                [keyValues setValue:self.Fuel forKey:@"Топливо:"];
            }
            else if ([subrubric isEqualToString:@"trucks"]) {
                
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
                [keyValues setValue:self.Mileage forKey:@"Пробег:"];
                [keyValues setValue:self.Color forKey:@"Цвет:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
                [keyValues setValue:self.Rudder forKey:@"Тип руля:"];
                [keyValues setValue:self.Gearbox forKey:@"Коробка передач:"];
                [keyValues setValue:self.Drive forKey:@"Тип привода:"];
                [keyValues setValue:self.BodyType forKey:@"Тип кузова:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
                [keyValues setValue:self.EngineCapacity forKey:@"Объём двигателя:"];
                [keyValues setValue:self.EnginePower forKey:@"Мощность:"];
                [keyValues setValue:self.VanVolume forKey:@"Объем фургона:"];
                [keyValues setValue:self.CabinType forKey:@"Тип кабины:"];
                [keyValues setValue:self.Fuel forKey:@"Топливо:"];
            }
            else if ([subrubric isEqualToString:@"small"]) {
                
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
                [keyValues setValue:self.Mileage forKey:@"Пробег:"];
                [keyValues setValue:self.Color forKey:@"Цвет:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
                [keyValues setValue:self.Rudder forKey:@"Тип руля:"];
                [keyValues setValue:self.Gearbox forKey:@"Коробка передач:"];
                [keyValues setValue:self.Drive forKey:@"Тип привода:"];
                [keyValues setValue:self.BodyType forKey:@"Тип кузова:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
                [keyValues setValue:self.EngineCapacity forKey:@"Объём двигателя:"];
                [keyValues setValue:self.EnginePower forKey:@"Мощность:"];
                [keyValues setValue:self.VanVolume forKey:@"Объем фургона:"];
                [keyValues setValue:self.Seats forKey:@"Число мест:"];
                [keyValues setValue:self.CabinType forKey:@"Тип кабины:"];
                [keyValues setValue:self.Capacity forKey:@"Грузоподъемность:"];
                [keyValues setValue:self.Fuel forKey:@"Топливо:"];
            }
            else if ([subrubric isEqualToString:@"trailers"]) {
                
                [keyValues setValue:self.Color forKey:@"Цвет:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
                [keyValues setValue:self.BodyType forKey:@"Тип кузова:"];
                [keyValues setValue:self.Capacity forKey:@"Грузоподъемность:"];
                [keyValues setValue:self.AxisCount forKey:@"Число осей:"];
            }
            else if ([subrubric isEqualToString:@"special"]) {
                
                [keyValues setValue:self.Color forKey:@"Цвет:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
                [keyValues setValue:self.BodyType forKey:@"Тип кузова:"];
                [keyValues setValue:self.Mileage forKey:@"Пробег:"];
                [keyValues setValue:self.EngineCapacity forKey:@"Объём двигателя:"];
                [keyValues setValue:self.EnginePower forKey:@"Мощность:"];
                [keyValues setValue:self.Fuel forKey:@"Топливо:"];
            }
        }
        else if ([rubric isEqualToString:@"moto"]) {
            
            [keyValues setValue:self.Color forKey:@"Цвет:"];
            [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
            [keyValues setValue:self.Status forKey:@"Состояние:"];
            [keyValues setValue:self.Year forKey:@"Год выпуска:"];
            [keyValues setValue:self.BodyType forKey:@"Тип кузова:"];
            [keyValues setValue:self.Mileage forKey:@"Пробег:"];
            [keyValues setValue:self.EngineCapacity forKey:@"Объём двигателя:"];
            [keyValues setValue:self.EnginePower forKey:@"Мощность:"];
            [keyValues setValue:self.Modification forKey:@"Модификация:"];
            [keyValues setValue:self.Fuel forKey:@"Топливо:"];
        }
        else if ([rubric isEqualToString:@"water"]) {
            if ([subrubric isEqualToString:@"hydros"]) {
                
                [keyValues setValue:self.Color forKey:@"Цвет:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
                [keyValues setValue:self.BodyType forKey:@"Тип кузова:"];
                [keyValues setValue:self.Type forKey:@"Тип:"];
                [keyValues setValue:self.EngineCapacity forKey:@"Объём двигателя:"];
                [keyValues setValue:self.EnginePower forKey:@"Мощность:"];
                [keyValues setValue:self.MotoHours forKey:@"Моточасы:"];
                [keyValues setValue:self.Fuel forKey:@"Топливо:"];
            }
            else if ([subrubric isEqualToString:@"yachts"]) {
                
                [keyValues setValue:self.Color forKey:@"Цвет:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
                [keyValues setValue:self.Displacement forKey:@"Водоизмещение:"];
                [keyValues setValue:self.EnginePower forKey:@"Мощность:"];
                [keyValues setValue:self.Seats forKey:@"Число мест:"];
            }
            else if ([subrubric isEqualToString:@"boats"]) {
                
                [keyValues setValue:self.Color forKey:@"Цвет:"];
                [keyValues setValue:self.Metalic forKey:@"Цвет металлик:"];
                [keyValues setValue:self.Year forKey:@"Год выпуска:"];
            }
        }
        else if ([rubric isEqualToString:@"gears"]) {
            if ([subrubric isEqualToString:@"wheels"]) {
                
                [keyValues setValue:self.Type forKey:@"Тип:"];
                [keyValues setValue:self.Material forKey:@"Материал:"];
                [keyValues setValue:self.Diameter forKey:@"Диаметр:"];
                [keyValues setValue:self.WheelWidth forKey:@"Ширина:"];
                [keyValues setValue:self.HolesCount forKey:@"Количество крепежных отверстий:"];
                [keyValues setValue:self.HoleDiameter forKey:@"Диаметр расположения крепежных отверстий:"];
                [keyValues setValue:self.Count forKey:@"Количество:"];
                [keyValues setValue:self.Color forKey:@"Цвет:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
            }
            else if ([subrubric isEqualToString:@"tires"]) {
                
                [keyValues setValue:self.Seasonality forKey:@"Сезонность:"];
                [keyValues setValue:self.Spikes forKey:@"Шипы:"];
                [keyValues setValue:self.Diameter forKey:@"Диаметр:"];
                [keyValues setValue:self.Width forKey:@"Ширина профиля:"];
                [keyValues setValue:self.Height forKey:@"Высота профиля:"];
                [keyValues setValue:self.Count forKey:@"Количество:"];
                [keyValues setValue:self.Status forKey:@"Состояние:"];
            }
        }
        else if ([rubric isEqualToString:@"parts"]) {
            [keyValues setValue:self.Name forKey:@"Наименование:"];
            [keyValues setValue:self.Status forKey:@"Состояние:"];
        }
    }
    
    return keyValues;
}

@end
