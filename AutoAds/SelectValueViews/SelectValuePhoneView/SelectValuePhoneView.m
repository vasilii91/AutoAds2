//
//  SelectValuePhoneView.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/2/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SelectValuePhoneView.h"

@implementation SelectValuePhoneView

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.labelHeader setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:18]];
    self.tableViewPhones.backgroundColor = [UIColor clearColor];
    
    dataManager = [KVDataManager sharedInstance];
}

+ (SelectValuePhoneView *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SelectValuePhoneView" owner:nil options:nil] lastObject];
}


#pragma mark - Private methods

- (void)cleanTextFields
{
    self.textFieldCode.text = nil;
    self.textFieldExtra.text = nil;
    self.textFieldNumber.text = nil;
}

#pragma mark - Actions

- (IBAction)clickOnOkButton:(id)sender
{
    [currentTextField resignFirstResponder];
    
    Phone *phone = [Phone new];
    phone.Extra = self.textFieldExtra.text;
    phone.Code = self.textFieldCode.text;
    phone.Number = self.textFieldNumber.text;
    
    [dataManager.selectedPhones addObject:phone];
    [self.tableViewPhones reloadData];
    [self cleanTextFields];
}


#pragma mark - @protocol UITextFieldDelegate <NSObject>

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    currentTextField = textField;
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataManager.selectedPhones count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ButtonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Phone *phone = [dataManager.selectedPhones objectAtIndex:indexPath.row];
    cell.textLabel.text = [phone fullPhone];
    cell.textLabel.font = [UIFont fontWithName:FONT_DINPro_MEDIUM size:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
