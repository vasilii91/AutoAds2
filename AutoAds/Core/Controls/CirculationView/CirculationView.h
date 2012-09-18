//
//  CirculationView.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InternalView : UIView

@property (nonatomic, retain) UIView *view;
@property (nonatomic, assign) NSInteger index;

+ (InternalView *)newInternalViewFromView:(UIView *)v index:(NSInteger)index;

@end


@interface CirculationView : UIView
{
    NSMutableArray *internalViews;
}

@property (nonatomic, assign) CGRect activeFrame;
@property (nonatomic, assign) NSInteger activeViewIndex;

- (void)initializeWithViews:(NSArray *)v;
- (void)scrollToRight;
- (void)scrollToLeft;

@end
