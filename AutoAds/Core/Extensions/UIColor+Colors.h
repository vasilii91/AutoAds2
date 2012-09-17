//
//  UIColor_Colors.h
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Colors)

+ (UIColor *)autoBlue;
+ (UIColor *)autoGray;

@end


@implementation UIColor (Colors)

+ (UIColor *)autoBlue {
    return [UIColor colorWithRed:0 green:96./255. blue:171./255. alpha:1.0];
}

+ (UIColor *)autoGray {
    return [UIColor colorWithWhite:0.86 alpha:1.0];
}

@end
