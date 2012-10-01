//
//  CheckedCell.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 10/1/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "CheckedCell.h"

@implementation CheckedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
