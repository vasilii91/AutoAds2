//
//  UIImageExtension.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "UIImageExtension.h"

@implementation UIImage (Extension)

- (UIImage *)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)scaleToSizeProportionaly:(CGSize)boxSize
{
    CGSize imageSize = self.size;
    CGSize resultSize = CGSizeZero;
    
    CGFloat k1 = boxSize.height / imageSize.height;
    CGFloat k2 = boxSize.width / imageSize.width;
    CGFloat k = MIN(k1, k2);
    
    if (k > 1) {
        resultSize = imageSize;
    }
    else {
        resultSize = CGSizeMake(imageSize.width * k, imageSize.height * k);
    }
    
    UIImage *image = [self scaleToSize:resultSize];
    
    return image;
}

@end
