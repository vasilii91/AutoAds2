//
//  AdvGroup.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/7/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvGroup.h"

@implementation AdvGroup

- (NSArray *)getObligatoryFields
{
    NSMutableArray *result = [NSMutableArray new];
    for (AdvField *field in self.fields) {
        if (field.isShownOnForm) {
            [result addObject:field];
        }
    }
    
    return result;
}

- (void)printFields
{
    for (AdvField *field in self.fields) {
        LOG(@"%@", field.nameEnglish);
    }
}
@end
