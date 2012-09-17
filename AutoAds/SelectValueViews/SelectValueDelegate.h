//
//  SelectValueDelegate.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectValueDelegate <NSObject>

- (void)valueWasSelected:(id)selectedValue;

@end
