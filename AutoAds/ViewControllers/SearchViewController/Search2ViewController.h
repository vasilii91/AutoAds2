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

@interface Search2ViewController : UIViewController<SelectValueDelegate>

@property (nonatomic, strong) AdvField *field;

@end
