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

@interface AdvertisementViewController ()

@end

@implementation AdvertisementViewController
@synthesize scrollView;


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        networkManager = [KVNetworkManager sharedInstance];
        [networkManager subscribe:self];
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
    self.navigationItem.rightBarButtonItems = @[bbi2];
    
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    
    [[NSUserDefaults standardUserDefaults] setValue:@([self.advertisement.Photo count]) forKey:COUNT_OF_PHOTOS_IN_CAR_PHOTOS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [networkManager savePhotosByPhotoContainer:self.advertisement.Photo];
    pleaseWaitAlertView = [[PleaseWaitAlertView alloc] initWithTitle:nil message:@"Загружаются фотографии...\n\n" delegate:self cancelButtonTitle:@"Остановить" otherButtonTitles: nil];

    [pleaseWaitAlertView show];
    
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


#pragma mark - Private methods 

- (void)addComponentsOnView
{
    [pleaseWaitAlertView dismissWithClickedButtonIndex:-1 animated:YES];
    [networkManager unsubscribe:self];
    
    AdvertisementHeader *header = [AdvertisementHeader loadView];
    header.userInteractionEnabled = YES;
    LOG(@"%@", NSStringFromCGRect(header.frame));
    
    header.labelCarName.text = [self.advertisement Name];
    header.labelNameAndCity.text = [self.advertisement getNameAndCity];
    header.labelPrice.text = [self.advertisement getCarPrice];
    
    [self.scrollView addSubview:header];
    
    AdvertisementCarPhotos *carPhotos = [AdvertisementCarPhotos loadView];
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


#pragma mark - @protocol KVNetworkDelegate

- (void)requestProcessed:(RequestType)requestId forId:(NSString *)identifier
{
    [self addComponentsOnView];
}

- (void)requestFailed:(RequestType)requestId forId:(NSString *)identifier error:(NSString *)message code:(int)code
{
    
}


#pragma mark - @protocol UIAlertViewDelegate <NSObject>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self addComponentsOnView];
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

@end
