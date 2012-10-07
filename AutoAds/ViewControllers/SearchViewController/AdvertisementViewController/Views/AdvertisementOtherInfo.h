//
//  AdvertisementOtherInfo.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertisementOtherInfoOne.h"

@interface AdvertisementOtherInfo : UIView
{
    CGFloat currentY;
}

- (void)addKey:(NSString *)key value:(NSString *)value;
- (void)addDelimeterWithText:(NSString *)text;
- (CGFloat)height;

@end
