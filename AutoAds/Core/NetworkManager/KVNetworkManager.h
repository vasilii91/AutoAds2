//
//  KVNetworkManager.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KVUrlRequest.h"
#import "Constants.h"
#import "AdvDictionaries.h"
#import "FileManagerCoreMethods.h"
#import "AdvertisementAdd.h"
#import "AdvField.h"

#define FNApiErrorConnection              -1
#define FNApiErrorResponseFormat          -2
#define FNApiErrorLogon                   -3

@protocol KVNetworkDelegate

- (void)requestProcessed:(RequestType)requestId forId:(NSString *)identifier;
- (void)requestFailed:(RequestType)requestId forId:(NSString *)identifier error:(NSString *)message code:(int)code;

@end

typedef enum {
    ApiCallGET,
    ApiCallPOST
} ApiCall;


@interface KVNetworkManager : NSObject<KVUrlRequestDelegate> {

    NSMutableArray *subscribers;
    NSMutableDictionary *requests;
    
    RequestType currentApiCall;
    NSString *currentCookie;
    
    NSString *userName;
    NSString *userPassword;
}

+ (KVNetworkManager*)sharedInstance;

- (void)subscribe:(NSObject<KVNetworkDelegate> *)subscriber;
- (void)unsubscribe:(NSObject<KVNetworkDelegate> *)subscriber;
- (void)removeAllSubscribers;
- (void)cancelRequest:(int)type forId:(NSString *)identifier;

/**
 Connect to server with username
 @param username Name of user
 @param password Password of user
 */
- (void)connectToServerWithUsername:(NSString *)username password:(NSString *)password;

- (NSString *)serverURL;
- (void)getCaptcha;
- (void)searchWithQuery:(NSString *)queryString isSearchWithPage:(BOOL)isSearchWithPage;
- (void)countOfNewAdvertisementsByQuery:(NSString *)queryString lastDate:(NSDate *)lastDate indexOfQuery:(NSInteger)index;
- (void)getModelsByRubric:(NSString *)rubric subrubric:(NSString *)subrubric;
- (void)getOptionsByRubric:(NSString *)rubric subrubric:(NSString *)subrubric;
- (void)savePhotosByPhotoContainer:(NSArray *)photoContainers;
- (void)addAdvertisementWithParameters:(NSDictionary *)parameters images:(NSArray *)images;

@end
