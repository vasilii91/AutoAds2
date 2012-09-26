//
//  KVDataLogic.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVDataLogic : NSObject

+ (NSDate *)dateWithJSONStringData:(NSString *)jsonString;
+ (NSDate *)dateWithMilliseconds:(NSString *)millisecondsString;
+ (NSString *)descriptionByStatusCode:(NSInteger)statusCode;

+ (NSString *)formattedFileSize:(unsigned long long)size;
+ (NSURL *)isExistFile:(NSString *)nameOfFile inDirectory:(NSString *)nameOfDirectory;
+ (NSURL *)createPathToFile:(NSString *)nameOfFile inDirectory:(NSString *)nameOfDirectory;
+ (void)deleteDirectory:(NSString *)nameOfDirectory;

@end
