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
@synthesize labelEmail;
@synthesize selectedValue;

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.labelHeader setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:18]];
    [self.labelEmail setHidden:YES];
}

+ (SelectValueStringView *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SelectValueStringView" owner:nil options:nil] lastObject];
}


#pragma mark - Actions

- (IBAction)clickOnOkButton:(id)sender
{
    [self.textFieldValue resignFirstResponder];
    
    BOOL isValidValue = YES;
    if (valueType == ValueTypeEmail) {
        isValidValue = [self isValidEmail:selectedValue];
        if (!isValidValue) {
            [self.labelEmail setHidden:NO];
        }
    }
    
    if (isValidValue) {
        [delegate valueWasSelected:self.selectedValue];
    }
}


#pragma mark - @protocol UITextFieldDelegate <NSObject>

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.selectedValue = textField.text;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (valueType == ValueTypeNumber) {
        [textFieldValue setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return YES;
}


#pragma mark - Private methods

-(BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
