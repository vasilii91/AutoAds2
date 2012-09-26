//
//  ListOfAdvertisementHeader.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CirculationView.h"

enum
{
    TypeOfSortByPriceAscending,
    TypeOfSortByPriceDescending,
    TypeOfSortByDateAscending,
    TypeOfSortByDateDescending
};
typedef NSUInteger TypeOfSort;

@protocol ListOfAdvertisementHeaderProtocol <NSObject>

- (void)userChoosenTypeOfSort:(TypeOfSort)typeOfSort;

@end


@interface ListOfAdvertisementHeader : UIView
{
    CGRect firstFrame;
    CGRect secondFrame;
    
    BOOL isAscending;
    BOOL isSortByPrice;
}

@property (weak, nonatomic) IBOutlet CirculationView *circulationView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewLabels;
@property (nonatomic, retain) NSObject<ListOfAdvertisementHeaderProtocol> *delegate;

+ (ListOfAdvertisementHeader *)loadView;
- (IBAction)clickOnTypeOfSortButton:(UIButton *)button;
- (IBAction)clickOnButtonAscDesc:(UIButton *)button;

@end
