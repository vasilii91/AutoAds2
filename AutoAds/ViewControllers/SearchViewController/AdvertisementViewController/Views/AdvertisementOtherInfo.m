//
//  AdvertisementOtherInfo.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementOtherInfo.h"

@implementation AdvertisementOtherInfo


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor clearColor]];
}


#pragma mark - Public methods

- (void)addKey:(NSString *)key value:(NSString *)value
{
    CGFloat fontSize = 20;
    
    AdvertisementOtherInfoOne *advInfoOne = [AdvertisementOtherInfoOne loadView];
    advInfoOne.frame = CGRectMake(10,
                                  currentY,
                                  300,
                                  fontSize);
    advInfoOne.labelKey.text = key;
    advInfoOne.labelValue.text = value;
    
    currentY += 2 * fontSize;

    [self addSubview:advInfoOne];    
}

- (void)addDelimeter
{
    currentY += 20;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundDark@2x.png"]];
    [imageView setFrame:CGRectMake(0,
                                   currentY,
                                   320,
                                   10)];
    [self addSubview:imageView];
}

- (CGFloat)height
{
    return currentY;
}

@end
