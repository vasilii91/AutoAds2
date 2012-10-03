//
//  Model.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/3/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brand, Modification;

@interface Model : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) NSSet *modifications;
@end

@interface Model (CoreDataGeneratedAccessors)

- (void)addModificationsObject:(Modification *)value;
- (void)removeModificationsObject:(Modification *)value;
- (void)addModifications:(NSSet *)values;
- (void)removeModifications:(NSSet *)values;

@end
