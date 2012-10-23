//
//  Query.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/30/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Query : NSManagedObject

@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSString * queryString;
@property (nonatomic, retain) NSString * queryStringRussian;
@property (nonatomic, retain) NSNumber * isSaved;

@end
