//
//  AdvertisementOtherInfoOption.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/8/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisementOtherInfoOption : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelValue;

+ (AdvertisementOtherInfoOption *)loadView;

@end
