//
//  AdvertisementCarPhotos.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/16/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvertisementCarPhotos.h"

@implementation AdvertisementCarPhotos
@synthesize pageControl;
@synthesize scrollViewPhotos;
@synthesize buttonShowOnSite;
@synthesize delegate;


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self.buttonShowOnSite.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:14]];
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
    gestureRecognizer.numberOfTapsRequired = 2;
    [self.scrollViewPhotos addGestureRecognizer:gestureRecognizer];
    
    imageViewPhotoWidth = scrollViewFrame.size.width;
    
    self.scrollViewPhotos.contentSize = CGSizeMake(scrollViewFrame.size.width * [names count],
                                                   scrollViewFrame.size.height);
    self.pageControl.numberOfPages = [names count];
}


#pragma mark - Actions

- (void)clickOnPhotoImageView:(UITapGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.scrollViewPhotos];
    NSInteger indexOfPhoto = point.x / imageViewPhotoWidth;
    
    [delegate userClickOnPhotoWithIndex:indexOfPhoto];
}

-(IBAction)clickOnCallButton:(id)sender
{
    LOG(@"call-button");
}

- (IBAction)clickOnSMSButton:(id)sender
{
    LOG(@"sms-button");
}

- (IBAction)clickOnShonOnSiteButton:(id)sender
{
    [delegate clickOnButton:CarPhotosButtonTypeShowOnSite];
}


#pragma mark - @protocol UIScrollViewDelegate<NSObject>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger numberOfPage = scrollView.contentOffset.x / self.scrollViewPhotos.frame.size.width;
    self.pageControl.currentPage = numberOfPage;
}

@end
