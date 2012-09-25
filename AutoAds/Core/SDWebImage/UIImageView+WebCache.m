/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image {
    //NSLog(@"%f %f %f %f", self.image.size.width, self.image.size.height, image.size.width, image.size.height);
    
    CGFloat wdelta = self.image.size.width / image.size.width;
    CGFloat hdelta = self.image.size.height / image.size.height;
    CGFloat delta = MIN(wdelta, hdelta);
    
    float x = (self.image.size.width - image.size.width * delta)/2;
    float y = (self.image.size.height - image.size.height * delta)/2;    
    UIGraphicsBeginImageContext(CGSizeMake(self.image.size.width, self.image.size.height));
    [image drawInRect:CGRectMake(x, y, image.size.width * delta, image.size.height * delta)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 
     
    self.image = newImage;
    
    
    // resize the imageView to fit the image size
    /*
    CGSize size = [image size];
    float factor = size.width / self.frame.size.width;
    if (factor < size.height / self.frame.size.height) {
        factor = size.height / self.frame.size.height;
    }
    
    float x = self.frame.origin.x + (self.image.size.width - size.width/factor)/2;
    float y = self.frame.origin.y + (self.image.size.height - size.height/factor)/2;
    CGRect rect = CGRectMake(x, y, size.width/factor, size.height/factor);
    self.frame = rect;
    self.image = image;
    */ 
}

@end
