//
//  LinkCell.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/17/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelLink;

+ (LinkCell *)loadView;

@end
