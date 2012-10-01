//
//  SelectValueCell.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SelectValueCell.h"

#define CHECKBOX_NAME @"checkbox.png"

@implementation SelectValueCell
@synthesize buttonChecked;
@synthesize labelTitle;
@synthesize isChecked;
@synthesize selectValueDictionaryType;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [labelTitle setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:14]];
    [labelTitle setTextColor:FONT_COLOR_MY_BLUE_COLOR];
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"50.png"]];
    [self setBackgroundView:iv];
}

+ (SelectValueCell *)loadViewWithCheckedButtonHiddenState:(BOOL)state
{
    SelectValueCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectValueCell" owner:nil options:nil] lastObject];
    cell.buttonChecked.hidden = state;
    return cell;
}

- (IBAction)clickOnCheckButton:(id)sender
{
    isChecked = !isChecked;
    
    [self setStateOfCheckButton];
}

- (void)setIsChecked:(BOOL)_isChecked
{
    isChecked = _isChecked;
    [self setStateOfCheckButton];
}

- (void)setStateOfCheckButton
{
    if (isChecked) {
        [self.buttonChecked setImage:[UIImage imageNamed:CHECKBOX_NAME] forState:UIControlStateNormal];
        [self addOptionToSelected];
    }
    else {
        [self.buttonChecked setImage:nil forState:UIControlStateNormal];
        [self removeOptionFromSelected];
    }
    self.buttonChecked.backgroundColor = [UIColor grayColor];
}

- (void)addOptionToSelected
{
    KVDataManager *dataManager = [KVDataManager sharedInstance];
    
    if (selectValueDictionaryType == SelectValueDictionaryOptions) {
        [dataManager.selectedOptions addObject:self.option];
    }
    else if (selectValueDictionaryType == SelectValueDictionaryFuel) {
        [dataManager.selectedFuels addObject:self.labelTitle.text];
    }
    else if (selectValueDictionaryType == SelectValueDictionaryModels) {
        [dataManager.selectedModels addObject:self.labelTitle.text];
    }
    else if (selectValueDictionaryType == SelectValueDictionaryStates) {
        [dataManager.selectedStates addObject:self.labelTitle.text];
    }
}

- (void)removeOptionFromSelected
{
    KVDataManager *dataManager = [KVDataManager sharedInstance];
    
    if (selectValueDictionaryType == SelectValueDictionaryOptions) {
        [dataManager.selectedOptions removeObject:self.option];
    }
    else if (selectValueDictionaryType == SelectValueDictionaryFuel) {
        [dataManager.selectedFuels removeObject:self.labelTitle.text];
    }
    else if (selectValueDictionaryType == SelectValueDictionaryModels) {
        [dataManager.selectedModels removeObject:self.labelTitle.text];
    }
    else if (selectValueDictionaryType == SelectValueDictionaryStates) {
        [dataManager.selectedStates removeObject:self.labelTitle.text];
    }
}


@end
