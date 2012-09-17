//
//  MainController.m
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "MainController.h"

static MainController *sharedControllerInstance;

@implementation MainController

+ (MainController *)sharedController
{
    if (sharedControllerInstance == nil) {
        sharedControllerInstance = [[self alloc] init];
    }
    
    return sharedControllerInstance;
}

@end
