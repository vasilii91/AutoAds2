//
//  AdvertisementOtherInfoOne.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementOtherInfoOne.h"

@implementation AdvertisementOtherInfoOne


#pragma mark - Initialization
@synthesize labelKey;
@synthesize labelValue;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.labelKey setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:14]];
    [self.labelKey setBackgroundColor:[UIColor clearColor]];
    
    [self.labelValue setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:14]];
    [self.labelValue setTextColor:FONT_COLOR_MY_BLUE_COLOR];
    [self.labelValue setBackgroundColor:[UIColor clearColor]];
}

+ (AdvertisementOtherInfoOne *)loadView
{
    AdvertisementOtherInfoOne *v = [[[NSBundle mainBundle] loadNibNamed:@"AdvertisementOtherInfoOne" owner:nil options:nil] lastObject];
    return v;
}

@end
