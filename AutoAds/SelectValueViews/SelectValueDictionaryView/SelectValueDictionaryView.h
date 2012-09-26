//
//  SelectValueDictionaryView.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectValueCell.h"
#import "SelectValueDelegate.h"

@interface SelectValueDictionaryView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewDictionary;
@property (nonatomic, retain) NSDictionary *dictionary;
@property (nonatomic, assign) NSObject<SelectValueDelegate> *delegate;
@property (weak, nonatomic) IBOutlet UILabel *labelHeader;

+ (SelectValueDictionaryView *)loadView;

@end
