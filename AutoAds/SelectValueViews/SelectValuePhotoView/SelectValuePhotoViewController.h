//
//  SelectValuePhotoView.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectValueDelegate.h"
#import "PrettyViews.h"
#import "OrderedDictionary.h"
#import "KVDataManager.h"

enum
{
    TypeOfUIImagePickerViewControllerGalery,
    TypeOfUIImagePickerViewControllerTakePhoto
};
typedef NSUInteger TypeOfUIImagePickerViewController;;

@interface SelectValuePhotoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    __strong UIPopoverController *photoGaleryPopoverController;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewSelectedPhotos;
@property (weak, nonatomic) IBOutlet UIButton *buttonSelectPhoto;
@property (weak, nonatomic) IBOutlet UIButton *buttonCompleted;
@property (weak, nonatomic) IBOutlet UILabel *labelHeader;
@property (nonatomic, assign) NSObject<SelectValueDelegate> *delegate;
@property (nonatomic, retain) NSString *labelName;
@property (nonatomic, retain) OrderedDictionary *selectedPhotos;

- (IBAction)clickOnSelectPhotoButton:(id)sender;
@end
