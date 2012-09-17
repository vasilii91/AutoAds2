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

- (UIImage *)scaleSize:(CGSize)oldSize toSize:(CGSize)newSize
{
    CGFloat newWidth = oldSize.width * newSize.height / oldSize.height;
    CGSize newCarPhotoSize = CGSizeMake(newWidth, newSize.height);
    
    if (newCarPhotoSize.width > newSize.width) {
        CGFloat newHeight = newSize.width / newCarPhotoSize.width * newSize.height;
        newCarPhotoSize = CGSizeMake(newSize.width, newHeight);
    }
    else if (newCarPhotoSize.height > newSize.height) {
        CGFloat newWidth = newSize.height / newCarPhotoSize.height * newSize.width;
        newCarPhotoSize = CGSizeMake(newWidth, newSize.height);
    }
    
    UIImage *image = [self scaleToSize:newCarPhotoSize];

    return image;
}

@end
