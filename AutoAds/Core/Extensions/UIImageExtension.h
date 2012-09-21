//
//  UIImageExtension.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Extension)

- (UIImage*)scaleToSize:(CGSize)size;
- (UIImage *)scaleToSizeProportionaly:(CGSize)newSize;

@end
