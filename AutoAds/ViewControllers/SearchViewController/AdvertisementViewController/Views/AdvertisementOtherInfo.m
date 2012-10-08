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
    CGRect rect = CGRectMake(10,
                             currentY,
                             300,
                             fontSize);
    if (value != nil && key != nil) {
        AdvertisementOtherInfoOne *advInfoOne = [AdvertisementOtherInfoOne loadView];
        advInfoOne.frame = rect;
        advInfoOne.labelKey.text = key;
        advInfoOne.labelValue.text = value;

        currentY += 2 * fontSize;
        [self addSubview:advInfoOne];
    }
    else if (value != nil && key == nil) {
        AdvertisementOtherInfoOption *advInfoOne = [AdvertisementOtherInfoOption loadView];
        advInfoOne.frame = rect;
        advInfoOne.labelValue.text = value;
        
        currentY += 2 * fontSize;
        [self addSubview:advInfoOne];
    }
}

- (void)addDelimeterWithText:(NSString *)text
{
    currentY += 20;
    
    CGRect delimeterFrame = CGRectMake(0,
                                       currentY,
                                       320,
                                       20);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundDark@2x.png"]];
    [imageView setFrame:delimeterFrame];
    
    delimeterFrame.origin.x = 10;
    UILabel *labelView = [[UILabel alloc] initWithFrame:delimeterFrame];
    labelView.font = [UIFont fontWithName:FONT_DINPro_BOLD size:14];
    labelView.text = text;
    labelView.textColor = [UIColor whiteColor];
    [labelView sizeToFit];
    labelView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:imageView];
    [self addSubview:labelView];
}

- (CGFloat)height
{
    return currentY;
}

@end
