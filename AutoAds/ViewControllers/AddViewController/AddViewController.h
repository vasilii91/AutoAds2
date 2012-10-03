//
//  AddViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyViews.h"
#import "ButtonCell.h"
#import "SearchManager.h"
#import "Search2ViewController.h"
#import "SavedSearchQueriesViewController.h"
#import "Constants.h"
#import "KVNetworkManager.h"
#import "KVDataManager.h"
#import "OLGhostAlertView.h"

@interface AddViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate, KVNetworkDelegate, UIAlertViewDelegate, SelectValueDelegate, ButtonCellDelegate>
{
    PleaseWaitAlertView *pleaseWaitAlertView;
    
    SearchManager *searchManager;
    KVNetworkManager *networkManager;
    KVDataManager *dataManager;
    
    NSArray *fields;
    AdvField *lastSelectedField;
    AdvGroup *currentGroup;
    
    NSString *lastSelectedRubric;
    NSString *lastSelectedSubrubric;
    
    AdvField *f0;
    AdvField *f1;
    AdvField *f2;
    
    NSString *currentRubric;
    NSString *currentSubrubric;
    
    OrderedDictionary *dictionaryPhotos;
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewFields;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
- (IBAction)clickOnAddAdvertisementButton:(id)sender;
@end
