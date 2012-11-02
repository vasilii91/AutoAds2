//
//  AdvertisementAdditionalInfo.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisementAdditionalInfo : UIView

+ (AdvertisementAdditionalInfo *)loadView;
@property (weak, nonatomic) IBOutlet UITextView *textViewAdditionalInfo;

@end
