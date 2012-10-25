//
//  Search2ViewController.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrettyViews.h"
#import "AdvField.h"
#import "SelectValueDelegate.h"
#import "SelectValueDictionaryView.h"
#import "SelectValueStringView.h"
#import "SelectValuePhotoViewController.h"
#import "SelectValuePhoneView.h"
#import "SelectValueOptionsView.h"
#import "KVDataManager.h"
#import "SelectValueCaptchaView.h"
#import "SVProgressHUD.h"

enum
{
    Search2ViewControllerTypeSearch,
    Search2ViewControllerTypeAddAdvertisement
};
typedef NSUInteger Search2ViewControllerType;


@interface Search2ViewController : UIViewController<SelectValueDelegate>
{
    KVDataManager *dataManager;
}
@property (nonatomic, strong) AdvField *field;
@property (nonatomic, assign) Search2ViewControllerType typeOfSearch2ViewController;

@end
