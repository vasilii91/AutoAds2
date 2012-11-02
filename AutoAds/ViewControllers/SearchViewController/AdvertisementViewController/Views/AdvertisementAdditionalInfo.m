//
//  AdvertisementOtherInfoOne.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementAdditionalInfo.h"

@implementation AdvertisementAdditionalInfo
@synthesize textViewAdditionalInfo;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self.textViewAdditionalInfo setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:12]];
    [self.textViewAdditionalInfo setBackgroundColor:[UIColor clearColor]];
    [self.textViewAdditionalInfo setUserInteractionEnabled:NO];
    [self.textViewAdditionalInfo setShowsVerticalScrollIndicator:NO];
}

+ (AdvertisementAdditionalInfo *)loadView
{
    AdvertisementAdditionalInfo *v = [[[NSBundle mainBundle] loadNibNamed:@"AdvertisementAdditionalInfo" owner:nil options:nil] lastObject];
    return v;
}

@end
