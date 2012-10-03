//
//  OptionsCategories.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/3/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CachedData, Options;

@interface OptionsCategories : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *options;
@property (nonatomic, retain) CachedData *cachedData;
@end

@interface OptionsCategories (CoreDataGeneratedAccessors)

- (void)addOptionsObject:(Options *)value;
- (void)removeOptionsObject:(Options *)value;
- (void)addOptions:(NSSet *)values;
- (void)removeOptions:(NSSet *)values;

@end
