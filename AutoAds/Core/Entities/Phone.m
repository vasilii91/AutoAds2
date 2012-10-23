//
//  Phone.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "Phone.h"

@implementation Phone

- (NSString *)fullPhone
{
    return [NSString stringWithFormat:@"%@%@%@", self.Extra, self.Code, self.Number];
}

- (NSString *)prettyPhone
{
    return [NSString stringWithFormat:@"+%@-%@-%@", self.Extra, self.Code, self.Number];
}
@end
