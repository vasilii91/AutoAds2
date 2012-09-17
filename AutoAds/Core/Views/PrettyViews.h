//
//  PrettyViews.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrettyViews : NSObject

+ (UILabel *)labelToNavigationBarWithTitle:(NSString *)title;
+ (UIBarButtonItem *)backBarButtonWithTarget:(id)target action:(SEL)action frame:(CGRect)frame imageName:(NSString *)imageName text:(NSString *)text;

@end
