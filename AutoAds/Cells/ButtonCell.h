//
//  ButtonCell.h
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHeightProtocol.h"

@class ButtonCell;

@protocol ButtonCellDelegate <NSObject>

- (void)didTapButtonInButtonCell:(ButtonCell *)cell;

@end

@interface ButtonCell : UITableViewCell <CellHeightProtocol>

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, weak) id <ButtonCellDelegate> delegate;

@end