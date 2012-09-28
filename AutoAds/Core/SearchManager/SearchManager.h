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
#import "objc/runtime.h"

@interface SearchManager : NSObject
{
    NSMutableDictionary *groups;
}

+ (SearchManager *)sharedMySingleton;
- (AdvGroup *)findGroupByGroupType:(GroupType)groupType;
- (AdvGroup *)categorySearchByRubric:(NSString *)rubric subrubric:(NSString *)subrubric;
- (AdvGroup *)categoryAddAdvertisementByRubric:(NSString *)rubric subrubric:(NSString *)subrubric;
- (NSString *)queryToSearch:(NSArray *)fields;
- (NSString *)queryToAddAdvertisement:(NSArray *)fields;
- (NSDictionary *)parametersToAddAdvertisement:(NSArray *)fields;

@end
