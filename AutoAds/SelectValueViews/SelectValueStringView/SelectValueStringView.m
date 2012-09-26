//
//  SelectValueStringView.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SelectValueStringView.h"

@implementation SelectValueStringView
@synthesize textFieldValue;
@synthesize delegate;
@synthesize valueType;

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.labelHeader setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:18]];
}

+ (SelectValueStringView *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SelectValueStringView" owner:nil options:nil] lastObject];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (valueType == ValueTypeNumber) {
        [textFieldValue setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return YES;
}

@end
