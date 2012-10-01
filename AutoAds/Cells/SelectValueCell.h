//
//  SelectValueCell.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Option.h"
#import "KVDataManager.h"

enum
{
    SelectValueDictionaryModels,
    SelectValueDictionaryFuel,
    SelectValueDictionaryStates,
    SelectValueDictionaryOptions,
    SelectValueDictionaryUnknown
};
typedef NSUInteger SelectValueDictionary;

@interface SelectValueCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *buttonChecked;
@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, retain) Option *option;
@property (nonatomic, assign) SelectValueDictionary selectValueDictionaryType;

+ (SelectValueCell *)loadViewWithCheckedButtonHiddenState:(BOOL)state;
- (IBAction)clickOnCheckButton:(id)sender;

@end
