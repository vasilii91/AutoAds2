//
//  AdvertisementOtherInfoOne.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisementOtherInfoOne : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelKey;
@property (weak, nonatomic) IBOutlet UILabel *labelValue;

+ (AdvertisementOtherInfoOne *)loadView;

@end
