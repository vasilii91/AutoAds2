//
//  AdvertisementViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementViewController.h"

#define FAVORITE_BUTTON_IMAGE_SELECTED @"zvezda_selected.png"
#define FAVORITE_BUTTON_IMAGE_DESELECTED @"zvezda.png"

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
    
//    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(clickOnFavoriteButton:) frame:CGRectMake(0, 0, 33, 33) imageName:FAVORITE_BUTTON_IMAGE_DESELECTED imageNameSelected:FAVORITE_BUTTON_IMAGE_DESELECTED text:nil];
//    self.navigationItem.rightBarButtonItems = @[bbi2];
    
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
    return NO;
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
    
    NSDictionary *keyValues = [_advertisement getAdvertisementKeyValues];
    
    for (NSString *key in [keyValues allKeys]) {
        NSString *value = [keyValues valueForKey:key];
        
        [advOtherInfo addKey:key value:value];
    }
    
    for (OptionsCategory *optionCategory in self.advertisement.Options) {
        [advOtherInfo addDelimeterWithText:optionCategory.title];
        for (Option *option in optionCategory.fields) {
            [advOtherInfo addKey:nil value:option.title];
        }
    }
    
    [self.scrollView addSubview:advOtherInfo];
    
    AdvertisementAdditionalInfo *additionalInfo = [AdvertisementAdditionalInfo loadView];
    additionalInfo.textViewAdditionalInfo.text = self.advertisement.Details;
    
    CGFloat contentHeight = [additionalInfo.textViewAdditionalInfo contentSize].height;
    
    CGRect addInfoFrame = CGRectMake(0,
                                     header.frame.size.height + carPhotos.frame.size.height + [advOtherInfo height],
                                     320,
                                     contentHeight);
    additionalInfo.frame = addInfoFrame;
    
    [self.scrollView addSubview:additionalInfo];
    
    [self.scrollView setContentSize:CGSizeMake(320,
                                               advFrame.origin.y + [advOtherInfo height] + contentHeight)];
}

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    NSMutableArray *convertedPhones = [NSMutableArray new];
    for (NSString *phone in recipients) {
        NSString *newPhoneFormat = [self convertPhoneToNormalFormat:phone];
        [convertedPhones addObject:newPhoneFormat];
    }
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = convertedPhones;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }    
}

- (NSString *)convertPhoneToNormalFormat:(NSString *)oldPhone
{
    NSArray *phones = [oldPhone componentsSeparatedByString:@","];
    oldPhone = [phones objectAtIndex:0];
    
    oldPhone = [oldPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    oldPhone = [oldPhone stringByReplacingOccurrencesOfString:@"(" withString:@"-"];
    oldPhone = [oldPhone stringByReplacingOccurrencesOfString:@")" withString:@"-"];
    
    return oldPhone;
}

- (void)callToPhone:(NSString *)phone
{
    phone = [self convertPhoneToNormalFormat:phone];
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
