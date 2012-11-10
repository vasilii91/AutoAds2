//
//  Advertisement.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "PhotoContainer.h"
#import "KVDataManager.h"
#import "AdvDictionaries.h"
#import "KVDataLogic.h"
#import "AdvValues.h"

@interface Advertisement : Jastor

@property (nonatomic, retain) NSString *AdvID;
@property (nonatomic, retain) NSString *RubricID;
@property (nonatomic, retain) NSString *UserID;
@property (nonatomic, retain) NSString *Brand;
@property (nonatomic, retain) NSString *Model;
@property (nonatomic, retain) NSString *Modification;
@property (nonatomic, retain) NSString *Year;
@property (nonatomic, retain) NSString *Mileage;
@property (nonatomic, retain) NSString *Color;
@property (nonatomic, retain) NSString *InternalColor;
@property (nonatomic, retain) NSString *Metalic;
@property (nonatomic, retain) NSString *Rudder;
@property (nonatomic, retain) NSString *Gearbox;
@property (nonatomic, retain) NSString *Drive;
@property (nonatomic, retain) NSString *BodyType;
@property (nonatomic, retain) NSString *Status;
@property (nonatomic, retain) NSString *EngineCapacity;
@property (nonatomic, retain) NSString *EnginePower;
@property (nonatomic, retain) NSString *Fuel;
@property (nonatomic, retain) NSString *EngineType;
@property (nonatomic, retain) NSString *Destiny;
@property (nonatomic, retain) NSString *Capacity;
@property (nonatomic, retain) NSString *VanVolume;
@property (nonatomic, retain) NSString *Seats;
@property (nonatomic, retain) NSString *CabinType;
@property (nonatomic, retain) NSString *AxisCount;
@property (nonatomic, retain) NSString *MotoHours;
@property (nonatomic, retain) NSString *Displacement;
@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSString *Seasonality;
@property (nonatomic, retain) NSString *Spikes;
@property (nonatomic, retain) NSString *Diameter;
@property (nonatomic, retain) NSString *WheelWidth;
@property (nonatomic, retain) NSString *Width;
@property (nonatomic, retain) NSString *Height;
@property (nonatomic, retain) NSString *Count;
@property (nonatomic, retain) NSString *Type;
@property (nonatomic, retain) NSString *Material;
@property (nonatomic, retain) NSString *HolesCount;
@property (nonatomic, retain) NSString *HoleDiameter;
@property (nonatomic, retain) NSString *Sortie;
@property (nonatomic, retain) NSArray *Options;
@property (nonatomic, retain) NSString *Price;
@property (nonatomic, retain) NSString *Chaffer;
@property (nonatomic, retain) NSString *Contacts;
@property (nonatomic, retain) NSString *Phone;
@property (nonatomic, retain) NSString *Details;
@property (nonatomic, retain) NSString *DateCreate;
@property (nonatomic, retain) NSString *DateValid;
@property (nonatomic, retain) NSString *DateUpdate;
@property (nonatomic, retain) NSString *IsVisible;
@property (nonatomic, retain) NSString *opt_InState;
@property (nonatomic, retain) NSString *opt_Title;
@property (nonatomic, retain) NSString *IsNew;
@property (nonatomic, retain) NSString *Moderate;
@property (nonatomic, retain) NSString *Remoderate;
@property (nonatomic, retain) NSString *Important;
@property (nonatomic, retain) NSString *ImportantTill;
@property (nonatomic, retain) NSString *IsFavorite;
@property (nonatomic, retain) NSString *FavRemark;
@property (nonatomic, retain) NSString *Email;
@property (nonatomic, retain) NSString *CityCode;
@property (nonatomic, retain) NSArray *Photo;
@property (nonatomic, retain) NSString *NumOfOwners;
@property (nonatomic, retain) NSString *VIN;
@property (nonatomic, retain) NSString *FromOfficialDealer;
@property (nonatomic, retain) NSString *url;

- (NSDate *)getDateCreated;
- (NSDate *)getDateUpdated;
- (NSString *)getFullCarName;
- (NSString *)getCarPrice;
- (NSString *)getOtherInfo;
- (NSString *)getNameAndCity;
- (NSString *)getAdvertisementInfo;
- (NSDictionary *)getAdvertisementKeyValues;

@end
