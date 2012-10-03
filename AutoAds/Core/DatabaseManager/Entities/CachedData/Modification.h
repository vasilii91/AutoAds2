//
//  Modification.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/3/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Model;

@interface Modification : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Model *model;

@end
