//
//  AdvertisementCarPhotos.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageExtension.h"
#import "FileManagerCoreMethods.h"

enum
{
    CarPhotosButtonTypeShowOnSite,
};
typedef NSUInteger CarPhotosButtonType;

@protocol CarPhotosProtocol <NSObject>

- (void)clickOnButton:(CarPhotosButtonType)carPhotosButtonType;

@end


@interface AdvertisementCarPhotos : UIView<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewPhotos;
@property (weak, nonatomic) IBOutlet UIButton *buttonShowOnSite;
@property (nonatomic, assign) NSObject<CarPhotosProtocol> *delegate;

+ (AdvertisementCarPhotos *)loadView;
- (IBAction)clickOnCallButton:(id)sender;
- (IBAction)clickOnSMSButton:(id)sender;
- (IBAction)clickOnShonOnSiteButton:(id)sender;

@end
