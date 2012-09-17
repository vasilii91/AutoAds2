//
//  CirculationView.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirculationView : UIView

@property (nonatomic, assign) CGRect activeFrame;
@property (nonatomic, assign) NSInteger activeViewIndex;
@property (nonatomic, retain) NSArray *views;

- (void)initializeWithViews:(NSArray *)v;
- (void)scrollToRight;
- (void)scrollToLeft;

@end
