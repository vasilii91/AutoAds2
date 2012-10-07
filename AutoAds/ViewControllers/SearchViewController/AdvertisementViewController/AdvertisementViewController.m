//
//  AdvertisementViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementViewController.h"

#define FAVORITE_BUTTON_IMAGE_SELECTED @"star_button_selected.png"
#define FAVORITE_BUTTON_IMAGE_DESELECTED @"star_button.png"

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
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(clickOnFavoriteButton:) frame:CGRectMake(0, 0, 33, 33) imageName:FAVORITE_BUTTON_IMAGE_DESELECTED imageNameSelected:FAVORITE_BUTTON_IMAGE_DESELECTED text:nil];
    self.navigationItem.rightBarButtonItems = @[bbi2];
    
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    
    [[NSUserDefaults standardUserDefaults] setValue:@([self.advertisement.Photo count]) forKey:COUNT_OF_PHOTOS_IN_CAR_PHOTOS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    pleaseWaitAlertView = [[PleaseWaitAlertView alloc] initWithTitle:nil message:@"Загружаются фотографии...\n\n\n" delegate:self cancelButtonTitle:@"Остановить" otherButtonTitles: nil];
//    [pleaseWaitAlertView show];
    
    [SVProgressHUD showWithStatus:PROGRESS_STATUS_PLEASE_WAIT_PHOTOS];
    
    [networkManager savePhotosByPhotoContainer:self.advertisement.Photo];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [networkManager unsubscribe:self];
    [SVProgressHUD dismiss];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark - Private methods 

- (void)addComponentsOnView
{
    [SVProgressHUD showSuccessWithStatus:PROGRESS_STATUS_SUCCESS_PHOTOS];
//    [pleaseWaitAlertView dismissWithClickedButtonIndex:-1 animated:YES];
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
    if (self.advertisement.Phone == nil) {
        [carPhotos setCallAndSendSMSButtonsToEnabledState:NO];
    }
    else {
        [carPhotos setCallAndSendSMSButtonsToEnabledState:YES];
    }
    
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
    
    [advOtherInfo addKey:@"Год выпуска:" value:_advertisement.Year];
    [advOtherInfo addKey:@"Пробег:" value:_advertisement.Mileage];
    [advOtherInfo addKey:@"Объём двигателя:" value:_advertisement.EngineCapacity];
    [advOtherInfo addKey:@"Мощность:" value:_advertisement.EnginePower];
    [advOtherInfo addKey:@"Коробка передач:" value:_advertisement.Gearbox];
    [advOtherInfo addKey:@"Тип руля:" value:_advertisement.Rudder];
    [advOtherInfo addKey:@"Тип привода:" value:_advertisement.Drive];
    [advOtherInfo addKey:@"Тип двигателя:" value:_advertisement.EngineType];
    [advOtherInfo addKey:@"Топливо:" value:_advertisement.Fuel];
    [advOtherInfo addKey:@"Тип кузова:" value:_advertisement.BodyType];
    [advOtherInfo addKey:@"Состояние:" value:_advertisement.Status];
    [advOtherInfo addKey:@"Цвет кузова:" value:_advertisement.Color];
    [advOtherInfo addKey:@"Цвет металлик:" value:_advertisement.Metalic];
    
    [advOtherInfo addDelimeterWithText:@"Дополнительная информация"];
    [advOtherInfo addKey:@"Avto" value:@"Reno"];
    [advOtherInfo addKey:@"Диаметр расположения крепежных отверстий" value:@"Reno"];
    [advOtherInfo addDelimeterWithText:@"Экстерьер"];
    [advOtherInfo addKey:@"Диаметр колеса" value:@"Reno"];
    [advOtherInfo addKey:@"Avto asdf asd fad sdf ;asd fkasdf " value:@"Reno 2"];
    
    [self.scrollView addSubview:advOtherInfo];
    
    [self.scrollView setContentSize:CGSizeMake(320,
                                               advFrame.origin.y + [advOtherInfo height] + 40)];
}

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }    
}

- (void)callToPhone:(NSString *)phone
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]]];
    }
}


#pragma mark - @protocol CarPhotosProtocol <NSObject>

- (void)clickOnButton:(CarPhotosButtonType)carPhotosButtonType
{
    if (carPhotosButtonType == CarPhotosButtonTypeShowOnSite) {
        AdvertisementWebViewController *vc = [[AdvertisementWebViewController alloc] initWithNibName:@"AdvertisementWebViewController" bundle:nil];
        vc.URLString = self.advertisement.url;
        vc.titleString = @"Объявление на сайте";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (carPhotosButtonType == CarPhotosButtonTypeCall) {
        if (self.advertisement.Phone != nil) {
            [self callToPhone:self.advertisement.Phone];
            LOG(@"%@", self.advertisement.Phone);
        }
    }
    else if (carPhotosButtonType == CarPhotosButtonTypeSendSms) {
        [self sendSMS:@"" recipientList:@[self.advertisement.Phone]];
    }
}

- (void)userClickOnPhotoWithIndex:(NSInteger)photoIndex
{
    NSArray *imagePathes = [FileManagerCoreMethods pathToImagesInDirectory:PHOTOS_DIRECTORY];
    
    NSMutableArray *arrayMyPhotos = [[NSMutableArray alloc] init];
    for (int i = 0; i < [imagePathes count]; i++) {
        UIImage *image = [UIImage imageWithContentsOfFile:[imagePathes objectAtIndex:i]];
        MyPhoto *photo = [[MyPhoto alloc] initWithImage:image];
        [arrayMyPhotos addObject:photo];
    }
    MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos: arrayMyPhotos];
    
    EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoController];
    
    navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentModalViewController:navController animated:YES];
    
    [photoController moveToPhotoAtIndex:photoIndex animated:NO];
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBackFromPhotoViewer:)];
    photoController.navigationItem.leftBarButtonItem = bbi;
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


#pragma mark - @protocol MFMessageComposeViewControllerDelegate <NSObject>

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled) {
        NSLog(@"Message cancelled");
    }
    else if (result == MessageComposeResultSent) {
        NSLog(@"Message sent");
    }
    else {
        NSLog(@"Message failed");
    }
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goBackFromPhotoViewer:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)clickOnFavoriteButton:(UIButton *)button
{
    
}

@end
