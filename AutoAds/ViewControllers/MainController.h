//
//  MainController.h
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainController : NSObject

@property (nonatomic, strong) UIViewController *mainMenuController;
@property (nonatomic, strong) UIViewController *tabBarController;

+ (MainController *)sharedController;

@end
