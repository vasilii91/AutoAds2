//
//  RubrikCell.h
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHeightProtocol.h"

@interface RubrikCell : UITableViewCell <CellHeightProtocol>

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@end
