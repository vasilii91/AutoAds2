//
//  ButtonCell.m
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

@synthesize textView;
@synthesize button;
@synthesize delegate = _delegate;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [self.textView setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:12.]];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    
    [self.button.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:12.]];
    [self.button setBackgroundImage:[[UIImage imageNamed:@"tableButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"50.png"]];
    [self setBackgroundView:iv];
}

- (CGFloat)cellHeight
{
    return 50;
}

+ (ButtonCell *)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ButtonCell" owner:nil options:nil] lastObject];
}


#pragma mark - Actions

- (void)onButton:(id)sender
{
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(ButtonCellDelegate)] && [_delegate respondsToSelector:@selector(didTapButtonInButtonCell:)]) {
        [_delegate didTapButtonInButtonCell:self];
    }
}

@end
