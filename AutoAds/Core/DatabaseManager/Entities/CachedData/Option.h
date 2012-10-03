//
//  Option.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/3/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CachedData;

@interface Option : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) CachedData *cachedData;

@end
