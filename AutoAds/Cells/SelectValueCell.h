//
//  SelectValueCell.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectValueCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *labelTitle;

+ (SelectValueCell *)loadView;

@end
