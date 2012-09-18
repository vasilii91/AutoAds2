//
//  SavedSearchQueriesViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyViews.h"
#import "SelectValueCell.h"
#import "TableViewHeader.h"
#import "SavedSearchCell.h"
#import "SearchViewController.h"

@interface SavedSearchQueriesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *latestSearchQueries;
    NSMutableArray *savedSearchQueries;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewSavedSearchQueries;
@property (weak, nonatomic) IBOutlet UIButton *buttonNewSearch;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;

- (IBAction)clickOnNewSearchButton:(id)sender;

@end
