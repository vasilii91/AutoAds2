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

@class KVUrlRequest;

@interface KVDataManager : NSObject

+ (KVDataManager *)sharedInstance;

/**
 Method to save definitely data from stream
 @param outputStream Stream with data
 @param type Type of request
 */
- (void)saveData:(NSOutputStream *)outputStream withRequestType:(int)type;

@end
