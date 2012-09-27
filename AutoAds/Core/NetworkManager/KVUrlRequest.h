//
//  KVUrlRequest.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "KVDataManager.h"
#import "KVDataLogic.h"
#import "KVDataManagerDelegate.h"

@class KVUrlRequest;
@class KVDataManager;

typedef enum {
    RequestTypeLogin,
    RequestTypeSearch,
    RequestTypeBrands,
    RequestTypePhotosOfCar,
    RequestTypeAddAdvertisement
} RequestType;

@protocol  KVUrlRequestDelegate

- (void)requestFailed:(KVUrlRequest *)request error:(NSError *)error;
- (void)requestSuccess:(KVUrlRequest *)request;

@end


@interface KVUrlRequest : NSObject<NSURLConnectionDelegate, KVDataManagerDelegate>
{
	NSURLConnection *_connection;
	NSURLRequest *_request;
	
	NSOutputStream *_outputStream;
	NSHTTPURLResponse *_httpResponse;
	NSObject<KVUrlRequestDelegate> *_delegate;
	
	BOOL _didFail;
	RequestType _tag;
    
    NSString *_identifier;
    
    KVDataManager *dataManager;
}

@property (nonatomic, readonly) NSOutputStream *outputStream;
@property (nonatomic, readonly) NSURLRequest *request;
@property (nonatomic, readonly) NSHTTPURLResponse *httpResponse;
@property (nonatomic, retain) NSObject<KVUrlRequestDelegate> *delegate;
@property (nonatomic, readonly) BOOL didFail;
@property (nonatomic, assign) RequestType type;
@property (nonatomic, retain) NSString *identifier;

- (id)initWithStream:(NSOutputStream *)stream request:(NSURLRequest *)request;
- (id)initWithStream:(NSOutputStream *)stream url:(NSString *)url;
- (BOOL)start;
- (void)stop;

- (NSString *)getUrl;
- (NSData *)getContent;

@end
