//
//  Photo.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "Photo.h"

@implementation Photo

+ (Class)large_class
{
    return [PhotoLarge class];
}

+ (Class)small_class
{
    return [PhotoSmall class];
}

@end
