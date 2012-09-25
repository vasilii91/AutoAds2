//
//  FileManagerCoreMethods.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/25/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface FileManagerCoreMethods : NSObject

+ (NSString *)createNewDirectoryWithName:(NSString *)directoryName;
+ (NSString *)deleteDirectoryWithName:(NSString *)directoryName;
+ (NSString *)deleteFile:(NSString *)fileName fromDirectory:(NSString *)directoryName;
+ (NSArray *)listOfFilesInDirectory:(NSString *)directoryName;
+ (NSArray *)pathToImagesInDirectory:(NSString *)directoryName;

@end
