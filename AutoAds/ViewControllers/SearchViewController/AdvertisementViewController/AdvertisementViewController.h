//
//  AdvertisementViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyViews.h"
#import "AdvertisementHeader.h"
#import "AdvertisementCarPhotos.h"
#import "AdvertisementOtherInfo.h"
#import "AdvertisementWebViewController.h"

@interface AdvertisementViewController : UIViewController<CarPhotosProtocol>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
