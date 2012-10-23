//
//  QueryPair.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/23/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderedDictionary.h"

@interface KVPair : NSObject

@property (nonatomic, retain) NSString *queryEnglish;
@property (nonatomic, retain) NSString *queryRussian;

+ (NSDictionary *)valuesByThisString:(NSString *)russianQueryString;

@end
