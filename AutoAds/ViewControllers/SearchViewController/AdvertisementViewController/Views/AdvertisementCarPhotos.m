//
//  AdvertisementCarPhotos.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementCarPhotos.h"

@implementation AdvertisementCarPhotos
@synthesize scrollViewPhotos;
@synthesize buttonShowOnSite;
@synthesize delegate;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self.buttonShowOnSite.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:14]];
    
//    [self.buttonCall setBackgroundImage:[UIImage imageNamed:@"trubka@2x.png"] forState:UIControlStateNormal];
}

+ (AdvertisementCarPhotos *)loadView
{
    AdvertisementCarPhotos *v = [[[NSBundle mainBundle] loadNibNamed:@"AdvertisementCarPhotos" owner:nil options:nil] lastObject];
    [v addPhotosFromDocuments];
    return v;
}

- (void)addPhotosFromDocuments
{
    NSArray *names = [FileManagerCoreMethods pathToImagesInDirectory:PHOTOS_DIRECTORY];
    
    CGRect scrollViewFrame = self.scrollViewPhotos.frame;
    
    for (int i = 0; i < [names count]; i++) {
        NSString *imageName = [names objectAtIndex:i];
        UIImage *carPhoto = [UIImage imageWithContentsOfFile:imageName];
        UIImage *newCarPhoto = [carPhoto scaleToSizeProportionaly:scrollViewFrame.size];
        
        CGRect newCarPhotoRect = CGRectMake((scrollViewFrame.size.width - newCarPhoto.size.width) / 2 + i * scrollViewFrame.size.width,
                                            (scrollViewFrame.size.height - newCarPhoto.size.height) / 2,
                                            newCarPhoto.size.width,
                                            newCarPhoto.size.height);
        UIImageView *carPhotoImageView = [[UIImageView alloc] initWithImage:newCarPhoto];
        carPhotoImageView.frame = newCarPhotoRect;
        
        [self.scrollViewPhotos addSubview:carPhotoImageView];
    }
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnPhotoImageView:)];
    gestureRecognizer.numberOfTapsRequired = 1;
    [self.scrollViewPhotos addGestureRecognizer:gestureRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognize = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnPhotoImageView:)];
    [self.scrollViewPhotos addGestureRecognizer:pinchRecognize];
    
    imageViewPhotoWidth = scrollViewFrame.size.width;
    
    self.scrollViewPhotos.contentSize = CGSizeMake(scrollViewFrame.size.width * [names count],
                                                   scrollViewFrame.size.height);
    
    CGRect f = CGRectMake(0, 48, 320, 20);
    myPageControl = [[PageControl alloc] initWithFrame:f];
    myPageControl.numberOfPages = [names count];
    myPageControl.delegate = self;
    [self addSubview:myPageControl];
}


#pragma mark - Public methods

- (void)setCallAndSendSMSButtonsToEnabledState:(BOOL)isEnabled
{
    self.buttonCall.enabled = isEnabled;
    self.buttonSendSMS.enabled = isEnabled;
}

#pragma mark - Actions

- (void)clickOnPhotoImageView:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL isNeedToOpen = NO;
    if (([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] && [gestureRecognizer state] == UIGestureRecognizerStateBegan) ||
        [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        isNeedToOpen = YES;
    }
    
    if (isNeedToOpen) {
        CGPoint point = [gestureRecognizer locationInView:self.scrollViewPhotos];
        NSInteger indexOfPhoto = point.x / imageViewPhotoWidth;
        
        [delegate userClickOnPhotoWithIndex:indexOfPhoto];
    }
}

-(IBAction)clickOnCallButton:(id)sender
{
    [delegate clickOnButton:CarPhotosButtonTypeCall];
}

- (IBAction)clickOnSMSButton:(id)sender
{
    [delegate clickOnButton:CarPhotosButtonTypeSendSms];
}

- (IBAction)clickOnShonOnSiteButton:(id)sender
{
    [delegate clickOnButton:CarPhotosButtonTypeShowOnSite];
}


#pragma mark - @protocol UIScrollViewDelegate<NSObject>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger numberOfPage = scrollView.contentOffset.x / self.scrollViewPhotos.frame.size.width;
    myPageControl.currentPage = numberOfPage;
}


#pragma mark - @protocol PageControlDelegate<NSObject>

- (void)pageControlPageDidChange:(PageControl *)pageControl
{
    CGRect newRect = self.scrollViewPhotos.frame;
    newRect.origin.x = imageViewPhotoWidth * pageControl.currentPage;
    
    [self.scrollViewPhotos scrollRectToVisible:newRect animated:YES];
}

@end
