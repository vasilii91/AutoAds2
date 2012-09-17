//
//  ListOfAdverisementViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyViews.h"
#import "SavedSearchCell.h"
#import "ListOfAdvertisementHeader.h"
#import "AdvertisementCell.h"
#import "AdvertisementViewController.h"

@interface ListOfAdverisementViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *searchedAdvertisements;
    BOOL isShowHeader;
    BOOL isSaved;
    ListOfAdvertisementHeader *listOfAdvertisementHeader;
    CGRect frameOfHeaderWhenHidden;
    CGRect frameOfHeaderWhenShown;
    CGRect frameOfTableViewWhenHidden;
    CGRect frameOfTableViewWhenShown;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewAdvertisement;

@end
