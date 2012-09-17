//
//  LinkCell.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/17/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "LinkCell.h"

@implementation LinkCell
@synthesize labelName;
@synthesize labelLink;

#pragma mark - Initialization

- (void)awakeFromNib
{
    [self.labelName setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:20]];
    [self.labelName setTextColor:FONT_COLOR_MY_BLUE_COLOR];
    
    [self.labelName setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:18]];
}

+ (LinkCell *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LinkCell" owner:nil options:nil] lastObject];
}
@end
