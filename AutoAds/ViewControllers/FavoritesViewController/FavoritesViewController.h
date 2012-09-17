//
//  FavoritesViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyViews.h"
#import "AdvertisementCell.h"
#import "AdvertisementViewController.h"

@interface FavoritesViewController : UIViewController<AdvertisementCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableViewFavorites;
@end
