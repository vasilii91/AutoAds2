//
//  SearchViewController.h
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonCell.h"
#import "PrettyViews.h"

@interface SearchViewControllerOld : UIViewController <UITableViewDataSource, UITableViewDelegate, ButtonCellDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
