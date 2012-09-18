//
//  ListOfAdvertisementHeader.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CirculationView.h"

@interface ListOfAdvertisementHeader : UIView
{
    CGRect firstFrame;
    CGRect secondFrame;
}

@property (weak, nonatomic) IBOutlet CirculationView *circulationView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewLabels;

+ (ListOfAdvertisementHeader *)loadView;
- (IBAction)clickOnTypeOfSortButton:(UIButton *)button;

@end
