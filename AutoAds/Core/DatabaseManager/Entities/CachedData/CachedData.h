//
//  CachedData.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/3/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brand;

@interface CachedData : NSManagedObject

@property (nonatomic, retain) NSString * rubric;
@property (nonatomic, retain) NSString * subrubric;
@property (nonatomic, retain) NSDate * dateUpdated;
@property (nonatomic, retain) NSSet *brands;
@property (nonatomic, retain) NSSet *optionCategories;
@end

@interface CachedData (CoreDataGeneratedAccessors)

- (void)addBrandsObject:(Brand *)value;
- (void)removeBrandsObject:(Brand *)value;
- (void)addBrands:(NSSet *)values;
- (void)removeBrands:(NSSet *)values;

- (void)addOptionCategoriesObject:(NSManagedObject *)value;
- (void)removeOptionCategoriesObject:(NSManagedObject *)value;
- (void)addOptionCategories:(NSSet *)values;
- (void)removeOptionCategories:(NSSet *)values;

@end
