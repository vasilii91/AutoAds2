//
//  FlipSegue.h
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface FlipSegue : UIStoryboardSegue
{
    UIViewController *sourceVC;
    UIViewController *destinationVC;
}
@end
