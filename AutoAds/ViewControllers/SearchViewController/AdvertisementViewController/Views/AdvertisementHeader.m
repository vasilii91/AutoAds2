//
//  AdvertisementHeader.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementHeader.h"

@implementation AdvertisementHeader
@synthesize labelCarName;
@synthesize labelNameAndCity;
@synthesize labelPrice;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.labelCarName setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:22]];
    [self.labelCarName setTextColor:FONT_COLOR_MY_BLUE_COLOR];
    [self.labelCarName setBackgroundColor:[UIColor clearColor]];
    
    [self.labelNameAndCity setFont:[UIFont fontWithName:FONT_DINPro_REGULAR size:16]];
    [self.labelNameAndCity setBackgroundColor:[UIColor clearColor]];
    
    [self.labelPrice setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:21]];
    [self.labelPrice setBackgroundColor:[UIColor clearColor]];
}

+ (AdvertisementHeader *)loadView
{
    AdvertisementHeader *v = [[[NSBundle mainBundle] loadNibNamed:@"AdvertisementHeader" owner:nil options:nil] lastObject];
    return v;
}


@end
