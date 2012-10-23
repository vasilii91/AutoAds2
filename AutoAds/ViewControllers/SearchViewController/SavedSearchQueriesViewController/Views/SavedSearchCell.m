//
//  SavedSearchCell.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SavedSearchCell.h"

@implementation SavedSearchCell
@synthesize labelBig;
@synthesize labelSmall;
@synthesize labelCount;

#pragma mark - Initialization

- (void)awakeFromNib
{
    [labelBig setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:13]];
    [labelBig setTextColor:FONT_COLOR_MY_BLUE_COLOR];
    [labelBig setBackgroundColor:[UIColor clearColor]];
    
    [labelSmall setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:9]];
    [labelSmall setBackgroundColor:[UIColor clearColor]];
    
    [labelCount setBackgroundColor:[UIColor clearColor]];
    [labelCount setTextColor:[UIColor redColor]];
}

+ (SavedSearchCell *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SavedSearchCell" owner:nil options:nil] lastObject];
}

@end
