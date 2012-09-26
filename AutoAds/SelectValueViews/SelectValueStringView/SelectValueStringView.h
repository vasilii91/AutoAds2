//
//  SelectValueStringView.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectValueDelegate.h"
#import "SearchManager.h"

@interface SelectValueStringView : UIView<UITextFieldDelegate>
{
    NSString *selectedValue;
}

@property (weak, nonatomic) IBOutlet UITextField *textFieldValue;
@property (nonatomic, assign) NSObject<SelectValueDelegate> *delegate;
@property (nonatomic, assign) ValueType valueType;
@property (weak, nonatomic) IBOutlet UILabel *labelHeader;

+ (SelectValueStringView *)loadView;
- (IBAction)clickOnOkButton:(id)sender;

@end
