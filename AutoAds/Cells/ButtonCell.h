//
//  ButtonCell.h
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellHeightProtocol.h"
#import "AdvField.h"

@class ButtonCell;

@protocol ButtonCellDelegate <NSObject>

- (void)userClickedOnAttentionButton:(AdvField *)field;

@end

@interface ButtonCell : UITableViewCell <CellHeightProtocol>

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonInfo;
@property (nonatomic, weak) id <ButtonCellDelegate> delegate;
@property (nonatomic, retain) AdvField *field;

+ (ButtonCell *)loadView;
- (void)setAttentionState:(BOOL)isAttention;
- (IBAction)clickOnAttentionButton:(id)sender;

@end