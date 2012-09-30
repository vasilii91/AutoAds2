//
//  SelectValueCaptchaView.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/30/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SelectValueCaptchaView.h"

@implementation SelectValueCaptchaView
@synthesize imageViewCaptcha;
@synthesize textFieldValue;
@synthesize delegate;

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.labelHeader setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:18]];
    
    KVNetworkManager *networkManager = [KVNetworkManager sharedInstance];
    [networkManager subscribe:self];
    [networkManager getCaptcha];
    
}

+ (SelectValueCaptchaView *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SelectValueCaptchaView" owner:nil options:nil] lastObject];
}


#pragma mark - Actions

- (IBAction)clickOnOkButton:(id)sender
{
    [self.textFieldValue resignFirstResponder];
    [delegate valueWasSelected:selectedValue];
}


#pragma mark - @protocol UITextFieldDelegate <NSObject>

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    selectedValue = textField.text;
}


#pragma mark - @protocol KVNetworkDelegate

- (void)requestProcessed:(RequestType)requestId forId:(NSString *)identifier
{
    if (requestId == RequestTypeGetCaptcha) {
        UIImage *placeholderImage = [UIImage imageWithContentsOfFile:PATH_TO_CAPTCHA_IMAGE];
        [self.imageViewCaptcha setImage:placeholderImage];
    }
}

- (void)requestFailed:(RequestType)requestId forId:(NSString *)identifier error:(NSString *)message code:(int)code
{
    
}


@end

