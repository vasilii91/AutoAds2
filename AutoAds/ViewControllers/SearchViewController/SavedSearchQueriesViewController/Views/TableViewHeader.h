//
//  TableViewHeader.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewHeader : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

+ (TableViewHeader *)loadView;

@end
