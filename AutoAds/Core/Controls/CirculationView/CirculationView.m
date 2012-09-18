//
//  CirculationView.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "CirculationView.h"

@implementation InternalView

+ (InternalView *)newInternalViewFromView:(UIView *)v index:(NSInteger)index
{
    InternalView *internalView = [InternalView new];
    internalView.view = v;
    internalView.index = index;
    
    return internalView;
}

@end


@implementation CirculationView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        internalViews = [NSMutableArray new];
    }
    return self;
}

- (void)initializeWithViews:(NSArray *)views
{
    CGRect activeRect = self.frame;
    
    NSArray *a1 = [views copy];
    NSArray *a2 = [views copy];
    [internalViews addObjectsFromArray:a1];
    [internalViews addObjectsFromArray:a2];
    
    for (int i = 0; i < [views count]; i++) {
        UIView *view = [views objectAtIndex:i];
        CGRect viewFrame = CGRectMake(activeRect.origin.x * i,
                                      0,
                                      activeRect.size.width,
                                      activeRect.size.height);
        view.frame = viewFrame;
        
        InternalView *internalView = [InternalView newInternalViewFromView:view index:i];
        [self addSubview:internalView.view];
    }
    
    
    UILabel *label = [internalViews objectAtIndex:0];
    [self addSubview:label];
}

- (void)scrollToRight
{
    [self addSubview:[internalViews objectAtIndex:1]];
}

- (void)scrollToLeft
{
    
}

@end
