//
//  AdvertisementCell.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdvertisementCellProtocol <NSObject>

- (void)userClickedOnFavoriteButtonWithIndex:(NSInteger)cellIndex;

@end

@interface AdvertisementCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewPhoto;
@property (weak, nonatomic) IBOutlet UILabel *labelCarName;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelOtherInfo;
@property (weak, nonatomic) IBOutlet UIButton *buttonFavorite;

@property (nonatomic, assign) NSInteger cellIndex;
@property (nonatomic, assign) BOOL isShowFavoriteButton;
@property (nonatomic, assign) NSObject<AdvertisementCellProtocol> *delegate;

+ (AdvertisementCell *)loadView;
- (IBAction)clickOnFavoriteButton:(id)sender;

@end
