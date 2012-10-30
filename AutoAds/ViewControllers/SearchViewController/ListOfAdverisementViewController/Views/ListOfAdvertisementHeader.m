//
//  ListOfAdvertisementHeader.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "ListOfAdvertisementHeader.h"

@implementation ListOfAdvertisementHeader
@synthesize circulationView;
@synthesize scrollViewLabels;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    isSortByPrice = YES;
}

+ (ListOfAdvertisementHeader *)loadView
{
    ListOfAdvertisementHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"ListOfAdvertisementHeader" owner:nil options:nil] lastObject];
    
    CGRect scroolViewRect = header.scrollViewLabels.frame;
    
    header->firstFrame = CGRectMake(0,
                                    0,
                                    scroolViewRect.size.width,
                                    scroolViewRect.size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:header->firstFrame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:FONT_DINPro_REGULAR size:24];
    label.textAlignment = UITextAlignmentCenter;
    [label setText:@"По цене"];
    [header.scrollViewLabels addSubview:label];
    
    header->secondFrame = CGRectMake(scroolViewRect.size.width,
                                     0,
                                     scroolViewRect.size.width,
                                     scroolViewRect.size.height);
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:header->secondFrame];
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont fontWithName:FONT_DINPro_REGULAR size:24];
    label2.textAlignment = UITextAlignmentCenter;
    [label2 setText:@"По дате"];
    [header.scrollViewLabels addSubview:label2];
    
    [header.scrollViewLabels setContentSize:CGSizeMake(scroolViewRect.size.width * 2,
                                                       scroolViewRect.size.height)];
    [header.scrollViewLabels setShowsHorizontalScrollIndicator:NO];
    [header.scrollViewLabels setShowsVerticalScrollIndicator:NO];
    
    return header;
}


#pragma mark - Actions

- (IBAction)clickOnTypeOfSortButton:(UIButton *)button
{ 
    if (button.tag == 0) {
        [self.scrollViewLabels scrollRectToVisible:firstFrame animated:YES];
        isSortByPrice = YES;
    }
    else {
        [self.scrollViewLabels scrollRectToVisible:secondFrame animated:YES];
        isSortByPrice = NO;
    }
    
    [self updateSortType];
}

- (IBAction)clickOnButtonAscDesc:(UIButton *)button
{
    if (button.tag == 0) {
        isAscending = YES;
    }
    else {
        isAscending = NO;
    }
    
    [self updateSortType];
}

- (void)updateSortType
{
    TypeOfSort typeOfSort;
    if (isAscending) {
        if (isSortByPrice) {
            typeOfSort = TypeOfSortByPriceAscending;
        }
        else {
            typeOfSort = TypeOfSortByDateAscending;
        }
    }
    else {
        if (isSortByPrice) {
            typeOfSort = TypeOfSortByPriceDescending;
        }
        else {
            typeOfSort = TypeOfSortByDateDescending;
        }
    }
    
    [self.delegate userChoosenTypeOfSort:typeOfSort];
}

@end
