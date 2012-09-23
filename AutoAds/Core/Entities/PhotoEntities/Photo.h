//
//  Photo.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoLarge.h"
#import "PhotoSmall.h"

@interface Photo : Jastor

@property (nonatomic, retain) PhotoLarge *large;
@property (nonatomic, retain) PhotoSmall *small;
@property (nonatomic, retain) NSString *Description;

@end
