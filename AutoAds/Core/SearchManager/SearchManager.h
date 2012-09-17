//
//  SearchManager.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvField.h"
#import "AdvGroup.h"
#import "AdvFieldNames.h"
#import "AdvValues.h"
#import "AdvDictionaries.h"
#import "OrderedDictionary.h"

@interface SearchManager : NSObject
{
    NSMutableArray *groups;
}

+ (SearchManager *)sharedMySingleton;
- (AdvGroup *)categoriesByRubric:(NSString *)rubric subrubric:(NSString *)subrubric;
- (AdvGroup *)getMainGroup;

@end
