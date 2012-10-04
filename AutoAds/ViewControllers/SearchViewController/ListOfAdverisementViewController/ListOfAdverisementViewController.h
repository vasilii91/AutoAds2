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
#import "DatabaseManager.h"
#import "KVNetworkManager.h"
#import "SearchManager.h"
#import "SVProgressHUD.h"

@interface ListOfAdverisementViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ListOfAdvertisementHeaderProtocol, KVNetworkDelegate>
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
    DatabaseManager *databaseManager;
    KVNetworkManager *networkManager;
    SearchManager *searchManager;
    
    NSInteger currentPage;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewAdvertisement;
@property (nonatomic, retain) NSString *queryString;

@end
