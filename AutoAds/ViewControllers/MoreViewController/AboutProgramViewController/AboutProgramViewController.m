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


#pragma mark - Private methods

- (void)emailLetterToRecipients:(NSArray *)recipients
{
	MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
	[mailViewController setSubject:@"Автообъявления"];
    [mailViewController setToRecipients:recipients];
    
	mailViewController.mailComposeDelegate = self;
	
	if (IS_IPAD) {
		mailViewController.modalPresentationStyle = UIModalPresentationPageSheet;
	}
	
    if (mailViewController == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"У Вас нету ни одного настроенного аккаунта" message:@"Если хотите использовать e-mail, Вы должны настроить по-крайней мере один почтовый ящик" delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        [self presentModalViewController:mailViewController animated:YES];
    }
	
}

- (void)callToPhone:(NSString *)phone
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]]];
    }
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
            [self callToPhone:@"+7-351-729-94-90"];
            break;
        }
        case 1:
        {
            [self emailLetterToRecipients:@[@"mobile.development@info74.ru"]];
            break;
        }
        case 2:
        {
            [self callToPhone:@"+375-44-573-31-92"];
            break;
        }
        case 3:
        {
            [self emailLetterToRecipients:@[@"vasilii91@gmail.com"]];
            break;
        }
    }
}


#pragma mark - @protocol MFMailComposeViewControllerDelegate <NSObject>

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
	
	NSString *mailError = nil;
	
	switch (result) {
		case MFMailComposeResultSent: ; break;
		case MFMailComposeResultFailed: mailError = @"Failed sending media, please try again...";
			break;
		default:
			break;
	}
	
	if (mailError != nil) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:mailError delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	}
}
@end
