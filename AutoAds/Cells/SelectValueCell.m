//
//  SelectValueCell.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SelectValueCell.h"

@implementation SelectValueCell
@synthesize labelTitle;

#pragma mark - Initialization

- (void)awakeFromNib
{
    [labelTitle setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:14]];
    [labelTitle setTextColor:FONT_COLOR_MY_BLUE_COLOR];
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"50.png"]];
    [self setBackgroundView:iv];
}

+ (SelectValueCell *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SelectValueCell" owner:nil options:nil] lastObject];
}


@end
