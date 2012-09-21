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

#define FNApiErrorConnection              -1
#define FNApiErrorResponseFormat          -2
#define FNApiErrorLogon                   -3

@protocol KVNetworkDelegate

- (void)requestProcessed:(int)requestId forId:(NSString *)identifier;
- (void)requestFailed:(int)requestId forId:(NSString *)identifier error:(NSString *)message code:(int)code;

@end


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

- (void)cancelRequest:(int)type forId:(NSString *)identifier;

/**
 Connect to server with username
 @param username Name of user
 @param password Password of user
 */
- (void)connectToServerWithUsername:(NSString *)username password:(NSString *)password;

- (void)search;

@end
