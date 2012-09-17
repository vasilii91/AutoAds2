//
//  AdvertisementViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementViewController.h"

#define FAVORITE_BUTTON_IMAGE_SELECTED @"starBlue.png"
#define FAVORITE_BUTTON_IMAGE_DESELECTED @"starBarIcon.png"

#define EXIT_BUTTON_IMAGE_SELECTED @"addBlue.png"
#define EXIT_BUTTON_IMAGE_DESELECTED @"addBarIcon.png"

@interface AdvertisementViewController ()

@end

@implementation AdvertisementViewController


#pragma mark - Initialization
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Объявление"];
    self.navigationItem.titleView = textLabel;
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(clickOnFavoriteButton:) frame:CGRectMake(0, 0, 33, 33) imageName:FAVORITE_BUTTON_IMAGE_DESELECTED text:nil];
    UIBarButtonItem *bbi3 = [PrettyViews backBarButtonWithTarget:self action:@selector(clickOnExitButton:) frame:CGRectMake(0, 0, 33, 33) imageName:EXIT_BUTTON_IMAGE_DESELECTED text:nil];
    self.navigationItem.rightBarButtonItems = @[bbi3, bbi2];
    
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    
    AdvertisementHeader *header = [AdvertisementHeader loadView];
    header.userInteractionEnabled = YES;
    LOG(@"%@", NSStringFromCGRect(header.frame));
    
    header.labelCarName.text = @"Ford C-MAX";
    header.labelNameAndCity.text = @"Владимир, Минск";
    header.labelPrice.text = @"5700$";
    
    [self.scrollView addSubview:header];
    
    AdvertisementCarPhotos *carPhotos = [AdvertisementCarPhotos loadView];
    [carPhotos addPhotosWithNames:@[@"thumbnail.png", @"addBlue@2x.png", @"backgroundLight@2x.png", @"logo@2x.png"]];
    carPhotos.delegate = self;
    carPhotos.userInteractionEnabled = YES;
    
    CGRect rect = carPhotos.frame;
    rect.origin.y = header.frame.size.height;
    [carPhotos setFrame:rect];
    
    [self.scrollView addSubview:carPhotos];
    
    AdvertisementOtherInfo *advOtherInfo = [AdvertisementOtherInfo new];
    CGRect advFrame = CGRectMake(0,
                                 header.frame.size.height + carPhotos.frame.size.height,
                                 320,
                                 200);
    advOtherInfo.frame = advFrame;
    
    [advOtherInfo addKey:@"Город:" value:@"Минск"];
    [advOtherInfo addKey:@"Avto" value:@"Reno"];
    [advOtherInfo addDelimeter];
    [advOtherInfo addKey:@"Avto" value:@"Reno"];
    [advOtherInfo addKey:@"Диаметр расположения крепежных отверстий" value:@"Reno"];
    [advOtherInfo addDelimeter];
    [advOtherInfo addKey:@"Диаметр колеса" value:@"Reno"];
    [advOtherInfo addKey:@"Avto asdf asd fad sdf ;asd fkasdf " value:@"Reno 2"];
    
    [self.scrollView addSubview:advOtherInfo];
    
    [self.scrollView setContentSize:CGSizeMake(320,
                                               advFrame.origin.y + [advOtherInfo height] + 40)];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark - @protocol CarPhotosProtocol <NSObject>

- (void)clickOnButton:(CarPhotosButtonType)carPhotosButtonType
{
    if (carPhotosButtonType == CarPhotosButtonTypeShowOnSite) {
        AdvertisementWebViewController *vc = [[AdvertisementWebViewController alloc] initWithNibName:@"AdvertisementWebViewController" bundle:nil];
        vc.URLString = @"http://www.google.by";
        vc.titleString = @"Объявление на сайте";
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickOnFavoriteButton:(UIButton *)button
{
    
}

- (void)clickOnExitButton:(UIButton *)button
{
    
}

@end
