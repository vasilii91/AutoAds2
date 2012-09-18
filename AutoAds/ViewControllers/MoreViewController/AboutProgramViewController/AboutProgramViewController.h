//
//  AboutProgramViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/17/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyViews.h"
#import <MessageUI/MessageUI.h>

@interface AboutProgramViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelAutoadvertisement;
@property (weak, nonatomic) IBOutlet UILabel *labelVersion;
@property (weak, nonatomic) IBOutlet UILabel *labelAutoChelRu;
@property (weak, nonatomic) IBOutlet UILabel *labelDeveloper;
@property (weak, nonatomic) IBOutlet UILabel *labelCopyright;

- (IBAction)clickOnButton:(UIButton *)sender;
@end
