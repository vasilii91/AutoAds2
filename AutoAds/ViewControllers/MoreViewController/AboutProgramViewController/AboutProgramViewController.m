//
//  AboutProgramViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/17/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AboutProgramViewController.h"

@interface AboutProgramViewController ()

@end

@implementation AboutProgramViewController

#pragma mark - Initialization
@synthesize labelAutoadvertisement;
@synthesize labelVersion;
@synthesize labelAutoChelRu;
@synthesize labelDeveloper;
@synthesize labelCopyright;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"О программе"];
    self.navigationItem.titleView = textLabel;
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    CGFloat fontSize = 14;
    self.labelAutoadvertisement.font = [UIFont fontWithName:FONT_DINPro_BOLD size:fontSize];
    self.labelVersion.font = [UIFont fontWithName:FONT_DINPro_MEDIUM size:fontSize];
    self.labelAutoChelRu.font = [UIFont fontWithName:FONT_DINPro_BOLD size:fontSize];
    self.labelDeveloper.font = [UIFont fontWithName:FONT_DINPro_BOLD size:fontSize];
    self.labelCopyright.font = [UIFont fontWithName:FONT_DINPro_MEDIUM size:fontSize];
}

- (void)viewDidUnload
{
    [self setLabelAutoadvertisement:nil];
    [self setLabelVersion:nil];
    [self setLabelAutoChelRu:nil];
    [self setLabelDeveloper:nil];
    [self setLabelCopyright:nil];
    [super viewDidUnload];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickOnButton:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            // first call button
            break;
        }
        case 1:
        {
            // first send button
            break;
        }
        case 2:
        {
            // second call button
            break;
        }
        case 3:
        {
            // second send button
            break;
        }
    }
}
@end
