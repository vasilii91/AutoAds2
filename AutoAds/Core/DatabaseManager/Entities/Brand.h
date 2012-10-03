//
//  Brand.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/3/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CachedData;

@interface Brand : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * order;
@property (nonatomic, retain) CachedData *cachedData;
@property (nonatomic, retain) NSSet *models;
@end

@interface Brand (CoreDataGeneratedAccessors)

- (void)addModelsObject:(NSManagedObject *)value;
- (void)removeModelsObject:(NSManagedObject *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
