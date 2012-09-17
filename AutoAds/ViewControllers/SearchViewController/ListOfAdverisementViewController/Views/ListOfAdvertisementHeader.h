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

@property (weak, nonatomic) IBOutlet CirculationView *circulationView;
+ (ListOfAdvertisementHeader *)loadView;
- (IBAction)clickOnTypeOfSortButton:(UIButton *)button;

@end
