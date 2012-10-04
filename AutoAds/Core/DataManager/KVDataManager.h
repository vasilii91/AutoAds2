//
//  KVDataManager.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVUrlRequest.h"
#import "JSON.h"
#import "Constants.h"
#import "Advertisement.h"
#import "VehicleBrand.h"
#import "KVDataManagerDelegate.h"
#import "OrderedDictionary.h"
#import "FileManagerCoreMethods.h"
#import "Option.h"
#import "OptionsCategory.h"
#import "DatabaseManager.h"

@class KVUrlRequest;

#define COUNT_ON_PAGE 20

@interface KVDataManager : NSObject

+ (KVDataManager *)sharedInstance;

@property (nonatomic, assign) NSObject<KVDataManagerDelegate> *delegate;
@property (nonatomic, retain) NSMutableArray *advertisements;
@property (nonatomic, retain) NSMutableArray *brands;
@property (nonatomic, retain) NSMutableArray *options;
@property (nonatomic, retain) NSMutableSet *selectedOptions;
@property (nonatomic, retain) NSMutableSet *selectedModels;
@property (nonatomic, retain) NSMutableSet *selectedFuels;
@property (nonatomic, retain) NSMutableSet *selectedStates;
@property (nonatomic, retain) NSMutableArray *selectedPhones;

@property (nonatomic, retain) NSDictionary *brandsDictionary;
@property (nonatomic, retain) NSDictionary *modelsDictionary;
@property (nonatomic, retain) NSDictionary *modificationsDictionary;
@property (nonatomic, retain) NSMutableDictionary *advCountDictionary;

@property (nonatomic, assign) NSInteger countOfLoadedImages;;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalCount;

/**
 Method to save definitely data from stream
 @param outputStream Stream with data
 @param type Type of request
 */
- (void)saveData:(NSOutputStream *)outputStream withRequestType:(int)type identifier:(NSString *)identifier;

- (NSString *)brandNameById:(NSString *)brandId;
- (NSString *)modelNameById:(NSString *)modelId;
- (NSString *)modificationNameById:(NSString *)modificationId;
- (void)cleanSelectedDataSourceByFieldName:(NSString *)fieldName;
- (void)cleanAllTempData;

@end
