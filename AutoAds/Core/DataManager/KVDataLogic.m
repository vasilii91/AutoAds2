//
//  KVDataLogic.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KVDataLogic.h"

@implementation KVDataLogic

+ (NSDate *)dateWithJSONStringData:(NSString *)jsonString
{
    NSString *dateString = jsonString;
    
    // Expect date in this format "/Date(1268123281843)/"
    int startPos = [dateString rangeOfString:@"("].location+1;
    int endPos = [dateString rangeOfString:@")"].location;
    NSRange range = NSMakeRange(startPos,endPos-startPos);
    unsigned long long milliseconds = [[dateString substringWithRange:range] longLongValue];
    NSLog(@"%llu",milliseconds);
    NSTimeInterval interval = milliseconds/1000;
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

+ (NSString *)descriptionByStatusCode:(NSInteger)statusCode
{
    NSString *description = @"";
    
    switch (statusCode) {
        case 200:
            description = @"OK";
            break;
        case 400:
            description = @"Bad request";
            break;
        case 401:
            description = @"Unauthorized";
            break;
        case 403:
            description = @"Forbidden";
            break;
        case 404:
            description = @"Bad URL";
            break;
        case 503:
            description = @"Service unavailable";
            break;
        case 500:
            description = @"Server error";
            break;
        default:
            break;
    }
    
    return description;
}

+ (NSString *)formattedFileSize:(unsigned long long)size
{
	NSString *formattedStr = nil;
    if (size == 0) {
		formattedStr = @"Empty";
    }
	else {
		if (size > 0 && size < 1024) {
			formattedStr = [NSString stringWithFormat:@"%qu bytes", size];
        }
        else {
            if (size >= 1024 && size < pow(1024, 2)) {
                formattedStr = [NSString stringWithFormat:@"%.1f KB", (size / 1024.)];
            }
            else {
                if (size >= pow(1024, 2) && size < pow(1024, 3)) {
                    formattedStr = [NSString stringWithFormat:@"%.2f MB", (size / pow(1024, 2))];
                }
                else {
                    if (size >= pow(1024, 3)) {
                        formattedStr = [NSString stringWithFormat:@"%.3f GB", (size / pow(1024, 3))];
                    }
                }
            }
        }
    }
	
	return formattedStr;
}


#pragma mark - Private methods

+ (NSString *)pathToDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    return documentsDirectoryPath;
}

#pragma mark - Public methods: work with filesystem

+ (NSURL *)isExistFile:(NSString *)nameOfFile inDirectory:(NSString *)nameOfDirectory
{
    NSString *documentsDirectory = [KVDataLogic pathToDocumentsDirectory];
    NSString *directory = [NSString stringWithFormat:@"%@/%@/%@", documentsDirectory, nameOfDirectory, nameOfFile];
    
    NSURL *storeURL = [NSURL fileURLWithPath:directory];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directory]) {
        return storeURL;
    }
    else {
        return nil;
    }
}

+ (NSURL *)createPathToFile:(NSString *)nameOfFile inDirectory:(NSString *)nameOfDirectory
{
    nameOfFile = [NSString stringWithFormat:@"%@/%@", nameOfDirectory, nameOfFile];
    NSString *documentsDirectory = [KVDataLogic pathToDocumentsDirectory];
    NSString *directory = [NSString stringWithFormat:@"%@/%@", documentsDirectory, nameOfDirectory];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:directory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *myPathDocs = [documentsDirectory stringByAppendingPathComponent:nameOfFile];
    NSURL *storeURL = [NSURL fileURLWithPath:myPathDocs];
    
    return storeURL;
}

+ (void)deleteDirectory:(NSString *)nameOfDirectory
{
    NSString *documentsDirectory = [KVDataLogic pathToDocumentsDirectory];
    NSString *tempFolder = [NSString stringWithFormat:@"%@/%@", documentsDirectory, nameOfDirectory];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:tempFolder]) {
        [[NSFileManager defaultManager] removeItemAtPath:tempFolder error:nil];
    }
}

@end
