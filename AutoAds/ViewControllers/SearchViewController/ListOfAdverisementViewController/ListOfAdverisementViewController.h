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
#import "KVDataManager.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "SVPullToRefresh.h"

@interface ListOfAdverisementViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ListOfAdvertisementHeaderProtocol>
{
    NSMutableArray *searchedAdvertisements;
    BOOL isShowHeader;
    BOOL isSaved;
    ListOfAdvertisementHeader *listOfAdvertisementHeader;
    CGRect frameOfHeaderWhenHidden;
    CGRect frameOfHeaderWhenShown;
    CGRect frameOfTableViewWhenHidden;
    CGRect frameOfTableViewWhenShown;
    
    KVDataManager *dataManager;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewAdvertisement;

@end
