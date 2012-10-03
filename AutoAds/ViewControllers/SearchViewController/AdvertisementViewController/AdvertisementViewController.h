//
//  AdvertisementViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyViews.h"
#import "Advertisement.h"
#import "AdvertisementHeader.h"
#import "AdvertisementCarPhotos.h"
#import "AdvertisementOtherInfo.h"
#import "AdvertisementWebViewController.h"
#import "KVNetworkManager.h"
#import "PleaseWaitAlertView.h"
#import "MyPhoto.h"
#import "MyPhotoSource.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import "SVProgressHUD.h"

@interface AdvertisementViewController : UIViewController<CarPhotosProtocol, KVNetworkDelegate, UIAlertViewDelegate, MFMessageComposeViewControllerDelegate>
{
    PleaseWaitAlertView *pleaseWaitAlertView;
    
    KVNetworkManager *networkManager;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) Advertisement *advertisement;

@end
