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
#import "PageControl.h"

enum
{
    CarPhotosButtonTypeShowOnSite,
    CarPhotosButtonTypeCall,
    CarPhotosButtonTypeSendSms,
};
typedef NSUInteger CarPhotosButtonType;

@protocol CarPhotosProtocol <NSObject>

- (void)clickOnButton:(CarPhotosButtonType)carPhotosButtonType;
- (void)userClickOnPhotoWithIndex:(NSInteger)photoIndex;

@end


@interface AdvertisementCarPhotos : UIView<UIScrollViewDelegate, PageControlDelegate>
{
    CGFloat imageViewPhotoWidth;
    PageControl *myPageControl;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewPhotos;
@property (weak, nonatomic) IBOutlet UIButton *buttonShowOnSite;
@property (weak, nonatomic) IBOutlet UIButton *buttonCall;
@property (weak, nonatomic) IBOutlet UIButton *buttonSendSMS;
@property (nonatomic, assign) NSObject<CarPhotosProtocol> *delegate;

+ (AdvertisementCarPhotos *)loadView;
- (IBAction)clickOnCallButton:(id)sender;
- (IBAction)clickOnSMSButton:(id)sender;
- (IBAction)clickOnShonOnSiteButton:(id)sender;

- (void)setCallAndSendSMSButtonsToEnabledState:(BOOL)isEnabled;

@end
