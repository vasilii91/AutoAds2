//
//  PleaseWaitAlertView.m
//  Good Earth
//
//  Created by Vasilii Kasnitski on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PleaseWaitAlertView.h"

@implementation PleaseWaitAlertView

- (void)layoutSubviews
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    indicator.center = CGPointMake(self.bounds.size.width / 2, 50);
    [indicator startAnimating];
    
    if (isAdded == NO) {
        [self addSubview:indicator];
        isAdded = YES;
    }
}


@end
