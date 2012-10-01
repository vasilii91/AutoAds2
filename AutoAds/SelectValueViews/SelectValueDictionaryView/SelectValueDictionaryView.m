//
//  SelectValueDictionaryView.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SelectValueDictionaryView.h"

@implementation SelectValueDictionaryView
@synthesize tableViewDictionary;
@synthesize selectValueDictionaryType;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLight.png"]];
    [self.tableViewDictionary setBackgroundView:iv];
    
    [self.labelHeader setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:18]];
}

+ (SelectValueDictionaryView *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SelectValueDictionaryView" owner:nil options:nil] lastObject];
}


#pragma mark - @protocol UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dictionary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell identifier";
    SelectValueCell *cell = [self.tableViewDictionary dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        if (self.selectValueDictionaryType == SelectValueDictionaryUnknown) {
            cell = [SelectValueCell loadViewWithCheckedButtonHiddenState:YES];
        }
        else {
            cell = [SelectValueCell loadViewWithCheckedButtonHiddenState:NO];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectValueDictionaryType = selectValueDictionaryType;
    
    NSString *value = [[self.dictionary allKeys] objectAtIndex:indexPath.row];
    cell.labelTitle.text = value;
    
    KVDataManager *dataManager = [KVDataManager sharedInstance];
    NSMutableSet *dataSource = nil;
    if (selectValueDictionaryType == SelectValueDictionaryStates) {
        dataSource = dataManager.selectedStates;
    }
    else if (selectValueDictionaryType == SelectValueDictionaryFuel) {
        dataSource = dataManager.selectedFuels;
    }
    else if (selectValueDictionaryType == SelectValueDictionaryModels) {
        dataSource = dataManager.selectedModels;
    }
    if ([dataSource containsObject:value]) {
        cell.isChecked = YES;
    }
    else {
        cell.isChecked = NO;
    }
    
    return cell;
}


#pragma mark - @protocol UITableViewDelegate<NSObject, UIScrollViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectValueDictionaryType == SelectValueDictionaryUnknown) {
        NSString *selectedValue = [[self.dictionary allKeys] objectAtIndex:indexPath.row];
        [self.delegate valueWasSelected:selectedValue];
    }
}

@end
