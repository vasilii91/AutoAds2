//
//  SelectValueOptionsView.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/1/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectValueDelegate.h"
#import "SelectValueCell.h"
#import "Option.h"
#import "OptionsCategory.h"

@interface SelectValueOptionsView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    BOOL isOptions;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewDictionary;
@property (nonatomic, retain) NSArray *options;
@property (nonatomic, assign) NSObject<SelectValueDelegate> *delegate;
@property (weak, nonatomic) IBOutlet UILabel *labelHeader;

+ (SelectValueOptionsView *)loadView;

@end
