//
//  AdvertisementOtherInfoOption.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/8/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementOtherInfoOption.h"

@implementation AdvertisementOtherInfoOption
@synthesize labelValue;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.labelValue setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:14]];
    [self.labelValue setTextColor:FONT_COLOR_MY_BLUE_COLOR];
    [self.labelValue setBackgroundColor:[UIColor clearColor]];
}

+ (AdvertisementOtherInfoOption *)loadView
{
    AdvertisementOtherInfoOption *v = [[[NSBundle mainBundle] loadNibNamed:@"AdvertisementOtherInfoOption" owner:nil options:nil] lastObject];
    return v;
}

@end
