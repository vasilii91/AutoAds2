//
//  CachedData.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/3/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CachedData : NSManagedObject

@property (nonatomic, retain) NSString * rubric;
@property (nonatomic, retain) NSString * subrubric;
@property (nonatomic, retain) NSDate * dateUpdated;
@property (nonatomic, retain) NSSet *brands;
@property (nonatomic, retain) NSSet *options;
@end

@interface CachedData (CoreDataGeneratedAccessors)

- (void)addBrandsObject:(NSManagedObject *)value;
- (void)removeBrandsObject:(NSManagedObject *)value;
- (void)addBrands:(NSSet *)values;
- (void)removeBrands:(NSSet *)values;

- (void)addOptionsObject:(NSManagedObject *)value;
- (void)removeOptionsObject:(NSManagedObject *)value;
- (void)addOptions:(NSSet *)values;
- (void)removeOptions:(NSSet *)values;

@end
