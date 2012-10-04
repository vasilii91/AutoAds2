//
//  PrettyViews.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "PrettyViews.h"

@implementation PrettyViews

+ (UILabel *)labelToNavigationBarWithTitle:(NSString *)title
{
    // this will appear as the title in the navigation bar
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:FONT_DINPro_REGULAR size:18];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(0, -1);
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    label.text = NSLocalizedString(title, @"");
    [label sizeToFit];
    
    return label;
}

+ (UIBarButtonItem *)backBarButtonWithTarget:(id)target action:(SEL)action frame:(CGRect)frame imageName:(NSString *)imageName imageNameSelected:(NSString *)imageNameSelected text:(NSString *)text
{
    UIButton *back = [[UIButton alloc] initWithFrame:frame];
    [back setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [back setBackgroundImage:[UIImage imageNamed:imageNameSelected] forState:UIControlStateHighlighted];
    [back setTitle:text forState:UIControlStateNormal];
    [back.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:13.]];
    [back.titleLabel setTextColor:[UIColor whiteColor]];
    [back.titleLabel setShadowColor:[UIColor blackColor]];
    [back.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    [back setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 2, 0)];
    [back addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)backBarButtonWithTarget:(id)target action:(SEL)action
{
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:target action:action frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" imageNameSelected:@"backButton.png" text:@"Назад"];
    
    return bbi;
}

@end
