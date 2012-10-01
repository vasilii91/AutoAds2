//
//  SelectValueOptionsView.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/1/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SelectValueOptionsView.h"

@implementation SelectValueOptionsView
@synthesize tableViewDictionary;

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLight.png"]];
    [self.tableViewDictionary setBackgroundView:iv];
    
    [self.labelHeader setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:18]];
    
    id option = [self.options objectAtIndex:0];
    if ([option isKindOfClass:[Option class]]) {
        isOptions = YES;
    }
}

+ (SelectValueOptionsView *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SelectValueOptionsView" owner:nil options:nil] lastObject];
}


#pragma mark - @protocol UITableViewDataSource<NSObject>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isOptions) {
        return 1;
    }
    else {
        return [self.options count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isOptions) {
        return [self.options count];
    }
    else {
        OptionsCategory *optionsCategory = [self.options objectAtIndex:section];
        return [optionsCategory.fields count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell identifier";
    SelectValueCell *cell = [self.tableViewDictionary dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [SelectValueCell loadView];
    }
    
    Option *option = nil;
    if (isOptions) {
        option = [self.options objectAtIndex:indexPath.row];
    }
    else {
        OptionsCategory *optionCategory = [self.options objectAtIndex:indexPath.section];
        option = [optionCategory.fields objectAtIndex:indexPath.row];
    }
    
    cell.labelTitle.text = option.title;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (isOptions) {
        return @"";
    }
    else {
        OptionsCategory *optionCategory = [self.options objectAtIndex:section];
        return optionCategory.title;
    }
}


@end
