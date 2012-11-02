//
//  MainMenuViewController.m
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/13/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "MainMenuViewController.h"
#import "SearchViewControllerOld.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController {
    IBOutlet UIButton *_searchButton;
    IBOutlet UIButton *_addButton;
    IBOutlet UIButton *_favButton;
    IBOutlet UIButton *_moreButton;
    
    IBOutlet UIView *_bottomBar;
    IBOutlet UIButton *_infoButton;
}


#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor autoGray]];
    [_bottomBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundDark.png"]]];
    
    UIFont *font = [UIFont fontWithName:FONT_DINPro_MEDIUM size:20.];
    [_searchButton.titleLabel setFont:font];
    [_addButton.titleLabel setFont:font];
    [_favButton.titleLabel setFont:font];
    [_moreButton.titleLabel setFont:font];
    
    [_infoButton.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_REGULAR size:14.]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}


#pragma mark - Actions

- (IBAction)clickOnButton:(UIButton *)button
{
    LOG(@"%d", button.tag);
    if (button.tag == 4) {
        HelpfulInfoViewController *hivc = [[HelpfulInfoViewController alloc] initWithNibName:@"HelpfulInfoViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:hivc];
        [self presentModalViewController:navigationController animated:YES];
//        [UIView transitionFromView:self.view toView:hivc.view duration:0.5 options:UIViewAnimationTransitionFlipFromLeft completion:^(BOOL finished) {}];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setInteger:button.tag forKey:SELECTED_TAB_BAR_INDEX];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
