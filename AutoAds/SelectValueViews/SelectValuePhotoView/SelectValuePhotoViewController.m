//
//  SelectValuePhotoView.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SelectValuePhotoViewController.h"

@implementation SelectValuePhotoViewController
@synthesize tableViewSelectedPhotos;
@synthesize labelHeader;
@synthesize buttonSelectPhoto;
@synthesize delegate;
@synthesize labelName;
@synthesize selectedPhotos;


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.labelHeader setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:18]];
    [self.labelHeader setText:self.labelName];
    [self.buttonSelectPhoto.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:14]];
    
    self.tableViewSelectedPhotos.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(cleanCurrentValue) frame:CGRectMake(0, 0, 39, 39) imageName:@"addBarIcon.png" text:nil];
    self.navigationItem.rightBarButtonItem = bbi2;
}


#pragma mark - Actions

- (IBAction)clickOnSelectPhotoButton:(id)sender
{
    if (selectedPhotos == nil) {
        selectedPhotos = [OrderedDictionary new];
    }
    
    [self showGalery];
}

- (void)cleanCurrentValue
{
    [selectedPhotos removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goBack:(id)sender
{
    [delegate valueWasSelected:selectedPhotos];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [selectedPhotos count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ButtonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSString *nameOfPhoto = [[selectedPhotos allKeys] objectAtIndex:indexPath.row];
    UIImage *photo = [selectedPhotos valueForKey:nameOfPhoto];
    cell.textLabel.text = nameOfPhoto;
    cell.textLabel.font = [UIFont fontWithName:FONT_DINPro_MEDIUM size:14];
    cell.imageView.image = photo;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - Private methods

- (UIImagePickerController *)customizePickerControllerWithType:(TypeOfUIImagePickerViewController)typeOfPickerController
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    
    if (typeOfPickerController == TypeOfUIImagePickerViewControllerTakePhoto) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.showsCameraControls = YES;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        else {
            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
    }
    else {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    return imagePickerController;
}

- (void)showGalery
{
    UIImagePickerController *picker = [self customizePickerControllerWithType:TypeOfUIImagePickerViewControllerGalery];
    
    [self.navigationController presentModalViewController:picker animated:YES];
}


#pragma mark - @protocol UIImagePickerControllerDelegate<NSObject>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    NSInteger count = [self.selectedPhotos count];
    [self.selectedPhotos setValue:selectedImage forKey:[NSString stringWithFormat:@"photo %d", count]];
    [self.tableViewSelectedPhotos reloadData];
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [photoGaleryPopoverController dismissPopoverAnimated:YES];
}

@end
