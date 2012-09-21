//
//  KVDataManager.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KVDataManager.h"

static KVDataManager *instance = nil;

@implementation KVDataManager

#pragma mark - Memory management

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

+ (KVDataManager *)sharedInstance
{
	if (instance == nil) {
		instance = [[KVDataManager alloc] init];
	}
	
	return instance;
}

#pragma mark - Public methods

- (void)saveData:(NSOutputStream *)outputStream withRequestType:(int)type
{
    if (type == RequestTypeLogin) {
        for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies])
        {
            NSString *currentCookie = [NSString stringWithFormat:@".ASPXAUTH: %@", [cookie value]];
            LOG(@"cookie - %@", currentCookie);
        }
    }
    else if (type == RequestTypeSearch) {
        NSData *data = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *parseData = [parser objectWithString:str];
        NSArray *advertisementsArray = [parseData valueForKey:@"Ads"];
        NSMutableArray *advertisements = [NSMutableArray new];
        
        for (NSDictionary *d in advertisementsArray) {
            Advertisement *advertisement = [[Advertisement alloc] initWithDictionary:d];
            [advertisements addObject:advertisement];
        }
        LOG(@"%@", advertisements);
    }
}

@end
