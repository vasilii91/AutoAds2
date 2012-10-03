//
//  Options.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/3/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OptionsCategories;

@interface Options : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) OptionsCategories *optionCategory;

@end
