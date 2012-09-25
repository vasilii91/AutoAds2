//
//  FileManagerCoreMethods.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/25/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "FileManagerCoreMethods.h"

@implementation FileManagerCoreMethods

+ (NSString *)createNewDirectoryWithName:(NSString *)directoryName
{
    NSString *newDirectoryFilePath = [DOCUMENTS_DIRECTORY stringByAppendingPathComponent:directoryName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager createDirectoryAtPath:newDirectoryFilePath withIntermediateDirectories:YES attributes:nil error:nil] == NO) {
        return nil;
    }
    
    return newDirectoryFilePath;
}

+ (NSString *)deleteDirectoryWithName:(NSString *)directoryName
{
    NSString *newDirectoryFilePath = [DOCUMENTS_DIRECTORY stringByAppendingPathComponent:directoryName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager removeItemAtPath:newDirectoryFilePath error:nil] == NO) {
        return nil;
    }
    
    return newDirectoryFilePath;
}

+ (NSString *)deleteFile:(NSString *)fileName fromDirectory:(NSString *)directoryName
{
    NSString *newFilePath = [directoryName stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if ([fileManager removeItemAtPath:newFilePath error:&error] == NO) {
        LOG(@"%@", [error description]);
        return nil;
    }
    
    return newFilePath;
}

+ (NSArray *)listOfFilesInDirectory:(NSString *)directoryName
{
    NSFileManager *filemgr =[NSFileManager defaultManager];
    NSArray *fileList = [filemgr contentsOfDirectoryAtPath:directoryName error:nil];
    
    NSMutableArray *fileList2 = [NSMutableArray new];
    for (int i = 0; i < [fileList count]; i++) {
        NSString *nameOfFile = [fileList objectAtIndex: i];
        if ([nameOfFile characterAtIndex:0] != '.') {
            // remove extension
            nameOfFile = [nameOfFile substringWithRange:NSMakeRange(0, [nameOfFile rangeOfString:@"."].location)];
            [fileList2 addObject:nameOfFile];
        }
    }
    
    LOG(@"%@", fileList2);
    
    return fileList2;
}

+ (NSArray *)pathToImagesInDirectory:(NSString *)directoryName
{
    NSArray *fileList = [FileManagerCoreMethods listOfFilesInDirectory:directoryName];
    
    NSComparisonResult (^sortBlock)(id, id) = ^(id obj1, id obj2) {
        
        NSInteger firstFileNumber = [obj1 integerValue];
        NSInteger secondFileNumber = [obj2 integerValue];
        if (firstFileNumber > secondFileNumber) {
            return NSOrderedDescending;
        }
        else if (firstFileNumber < secondFileNumber) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    };

    fileList = [fileList sortedArrayUsingComparator:sortBlock];
    
    NSMutableArray *imagePathes = [NSMutableArray new];
    for (int i = 0; i < [fileList count]; i++) {
        NSString *fileName = [fileList objectAtIndex:i];
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@.%@", directoryName, fileName, PHOTOS_EXTENSION];
        [imagePathes addObject:imagePath];
    }

    return imagePathes;
}

@end
