//
//  QueryPair.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/23/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "KVPair.h"

@implementation KVPair

+ (NSDictionary *)valuesByThisString:(NSString *)russianQueryString
{
    OrderedDictionary *result = [OrderedDictionary new];
    NSArray *array = [russianQueryString componentsSeparatedByString:@"&"];
    for (NSString *value in array) {
        NSArray *keyValue = [value componentsSeparatedByString:@"="];
        [result setValue:[keyValue objectAtIndex:1] forKey:[keyValue objectAtIndex:0]];
    }
    
    return result;
}
@end
