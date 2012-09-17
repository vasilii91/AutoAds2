//
//  AdvertisementHeader.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisementHeader : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelCarName;
@property (weak, nonatomic) IBOutlet UILabel *labelNameAndCity;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;

+ (AdvertisementHeader *)loadView;

@end
