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

@class KVUrlRequest;

@interface KVDataManager : NSObject

+ (KVDataManager *)sharedInstance;

@property (nonatomic, assign) NSObject<KVDataManagerDelegate> *delegate;
@property (nonatomic, retain) NSMutableArray *advertisements;
@property (nonatomic, retain) NSMutableArray *brands;
@property (nonatomic, retain) NSDictionary *brandsDictionary;
@property (nonatomic, retain) NSDictionary *modelsDictionary;
@property (nonatomic, retain) NSDictionary *modificationsDictionary;

/**
 Method to save definitely data from stream
 @param outputStream Stream with data
 @param type Type of request
 */
- (void)saveData:(NSOutputStream *)outputStream withRequestType:(int)type;

@end
