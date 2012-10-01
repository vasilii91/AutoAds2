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
#import "SelectValueOptionsView.h"
#import "KVDataManager.h"
#import "SelectValueCaptchaView.h"

@interface Search2ViewController : UIViewController<SelectValueDelegate>
{
    KVDataManager *dataManager;
}
@property (nonatomic, strong) AdvField *field;

@end
