//
//  FlipSegue.m
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "FlipSegue.h"

@implementation FlipSegue

- (NSString *)identifier {
    return @"flipSegue";
}

- (void)perform {
    
    sourceVC = self.sourceViewController;
    destinationVC = self.destinationViewController;
    
    if ([destinationVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (UITabBarController *)destinationVC;
        tbc.selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:SELECTED_TAB_BAR_INDEX];
//        [tbc.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBackground.png"]];
        
        NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:FONT_DINPro_REGULAR size:11.], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, [UIColor blackColor], UITextAttributeTextShadowColor, [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], UITextAttributeTextShadowOffset, nil];
        
        UITabBarItem *item1 = [tbc.tabBar.items objectAtIndex:0];
        [item1 setFinishedSelectedImage:[UIImage imageNamed:@"searchBarIconSelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"searchBarIcon.png"]];
        [item1 setTitle:@"Поиск"];
        [item1 setTitleTextAttributes:attr forState:UIControlStateNormal];
        
        UITabBarItem *item2 = [tbc.tabBar.items objectAtIndex:1];
        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"addBarIconSelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"addBarIcon.png"]];
        [item2 setTitle:@"Добавить"];
        [item2 setTitleTextAttributes:attr forState:UIControlStateNormal];
        
//        UITabBarItem *item3 = [tbc.tabBar.items objectAtIndex:2];
//        [item3 setFinishedSelectedImage:[UIImage imageNamed:@"starBarIconSelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"starBarIcon.png"]];
//        [item3 setTitle:@"Избранные"];
//        [item3 setTitleTextAttributes:attr forState:UIControlStateNormal];
        
        UITabBarItem *item4 = [tbc.tabBar.items objectAtIndex:2];
        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"moreBarIconSelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"moreBarIcon.png"]];
        [item4 setTitle:@"Еще"];
        [item4 setTitleTextAttributes:attr forState:UIControlStateNormal];
        
        [tbc.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tabbarSelection.png"]];
    }
    
    [SVProgressHUD showWithStatus:PROGRESS_STATUS_PLEASE_WAIT];
    
    [self performSelector:@selector(showNewViewController) withObject:nil afterDelay:0.3];
}

- (void)showNewViewController
{
    [UIView transitionFromView:sourceVC.view toView:destinationVC.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        [[UIApplication sharedApplication].keyWindow setRootViewController:destinationVC];
    }];
}

@end
