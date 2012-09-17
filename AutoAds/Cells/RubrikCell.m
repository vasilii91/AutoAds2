//
//  RubrikCell.m
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "RubrikCell.h"

@implementation RubrikCell

@synthesize titleLabel = _titleLabel;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [_titleLabel setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:14]];
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"40.PNG"]];
    [self setBackgroundView:iv];
}

- (CGFloat)cellHeight
{
    return 40;
}

@end
