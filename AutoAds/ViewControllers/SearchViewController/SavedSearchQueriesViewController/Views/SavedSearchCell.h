//
//  SavedSearchCell.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedSearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelBig;
@property (weak, nonatomic) IBOutlet UILabel *labelSmall;
+ (SavedSearchCell *)loadView;

@end
