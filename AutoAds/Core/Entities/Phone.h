//
//  Phone.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Phone : NSObject

@property (nonatomic, retain) NSString *Code;
@property (nonatomic, retain) NSString *Number;
@property (nonatomic, retain) NSString *Extra;

- (NSString *)fullPhone;

@end
