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

@interface AddViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>
{
    SearchManager *searchManager;
    
    NSArray *fields;
    AdvField *lastSelectedField;
    AdvGroup *currentGroup;
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewFields;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@end
