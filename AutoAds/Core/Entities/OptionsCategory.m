//
//  OptionsCategory.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "OptionsCategory.h"

@implementation OptionsCategory

- (id)init
{
    self = [super init];
    if (self) {
        self.fields = [NSMutableArray new];
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", self.title, self.fields];
}

@end
