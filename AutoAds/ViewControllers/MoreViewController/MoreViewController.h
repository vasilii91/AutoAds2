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

@interface MoreViewController : UIViewController
{
    NSDictionary *dictionaryLinks;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewLinks;

@end
