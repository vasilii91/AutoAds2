//
//  SelectValueCaptchaView.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/30/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectValueDelegate.h"
#import "KVNetworkManager.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

@interface SelectValueCaptchaView : UIView<UITextFieldDelegate, KVNetworkDelegate>
{
    NSString *selectedValue;
}

@property (weak, nonatomic) IBOutlet UITextField *textFieldValue;
@property (nonatomic, assign) NSObject<SelectValueDelegate> *delegate;
@property (weak, nonatomic) IBOutlet UILabel *labelHeader;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCaptcha;

+ (SelectValueCaptchaView *)loadView;
- (IBAction)clickOnOkButton:(id)sender;

@end
