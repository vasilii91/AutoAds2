//
//  Option.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "Option.h"

@implementation Option

- (NSString *)description
{
    return [NSString stringWithFormat:@"%d - %@", self.id, self.title];
}

@end
