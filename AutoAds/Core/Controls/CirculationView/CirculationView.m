//
//  CirculationView.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "CirculationView.h"

@implementation CirculationView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)initializeWithViews:(NSArray *)v
{
    self.views = v;
    
    UILabel *label = [self.views objectAtIndex:0];
    [self addSubview:label];
}

- (void)scrollToRight
{
    [self addSubview:[self.views objectAtIndex:1]];
}

- (void)scrollToLeft
{
    
}

@end
