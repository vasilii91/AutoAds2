//
//  MoreViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyViews.h"
#import "LinkCell.h"
#import "TableViewHeader.h"
#import "AdvertisementWebViewController.h"
#import "TechnicalHelpViewController.h"
#import "AboutProgramViewController.h"
#import "OrderedDictionary.h"
#import "AdvDictionaries.h"
#import "SVProgressHUD.h"

@interface MoreViewController : UIViewController
{
    NSDictionary *dictionaryLinks;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewLinks;

- (IBAction)clickOnTechnicalHelpButton:(id)sender;
- (IBAction)clickOnAboutProgramButton:(id)sender;


@end
