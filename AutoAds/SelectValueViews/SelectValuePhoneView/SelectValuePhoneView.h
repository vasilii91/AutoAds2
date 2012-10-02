//
//  SelectValuePhoneView.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/2/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVDataManager.h"
#import "Phone.h"

@interface SelectValuePhoneView : UIView
{
    KVDataManager *dataManager;
    UITextField *currentTextField;
}

@property (weak, nonatomic) IBOutlet UILabel *labelHeader;
@property (weak, nonatomic) IBOutlet UITableView *tableViewPhones;
@property (weak, nonatomic) IBOutlet UITextField *textFieldExtra;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCode;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNumber;

+ (SelectValuePhoneView *)loadView;
- (IBAction)clickOnOkButton:(id)sender;

@end
