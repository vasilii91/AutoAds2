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

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLight.png"]];
    [self.tableViewDictionary setBackgroundView:iv];
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
        cell = [SelectValueCell loadView];
    }
    
    NSString *value = [[self.dictionary allKeys] objectAtIndex:indexPath.row];
    cell.labelTitle.text = value;
    
    return cell;
}


#pragma mark - @protocol UITableViewDelegate<NSObject, UIScrollViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedValue = [[self.dictionary allKeys] objectAtIndex:indexPath.row];
    [self.delegate valueWasSelected:selectedValue];
}

@end
