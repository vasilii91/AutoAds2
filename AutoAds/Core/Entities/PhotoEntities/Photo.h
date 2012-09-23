//
//  Photo.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, retain) NSData *large;
@property (nonatomic, retain) NSData *small;
@property (nonatomic, retain) NSString *Description;

@end
