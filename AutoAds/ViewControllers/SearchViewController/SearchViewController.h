//
//  SearchViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "ButtonCell.h"
#import "PrettyViews.h"
#import "SSIndicatorLabel.h"
#import "PleaseWaitAlertView.h"
#import "SearchManager.h"
#import "Search2ViewController.h"
#import "SavedSearchQueriesViewController.h"
#import "ListOfAdverisementViewController.h"
#import "KVNetworkManager.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ButtonCellDelegate, KVNetworkDelegate>
{
    IBOutlet UIView *_header;
    IBOutlet UIButton *_searchButton;
    PleaseWaitAlertView *pleaseWaitAlertView;
    
    SearchManager *searchManager;
    
    NSArray *fields;
    AdvField *lastSelectedField;
    AdvGroup *currentGroup;
    
    NSString *lastSelectedRubric;
    NSString *lastSelectedSubrubric;
    
    KVNetworkManager *networkManager;
}
@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)clickOnSearchButton:(id)sender;

@end