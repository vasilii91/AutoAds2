//
//  TableViewHeader.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "TableViewHeader.h"

@implementation TableViewHeader
@synthesize labelTitle;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [labelTitle setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:14]];
    [labelTitle setTextColor:[UIColor whiteColor]];
}

+ (TableViewHeader *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TableViewHeader" owner:nil options:nil] lastObject];
}

@end
