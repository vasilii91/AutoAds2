//
//  AddViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AddViewController.h"

#define TABLE_CELL_HEIGHT 50
#define BUTTON_HEIGHT 64
#define WEB_VIEW_HEIGHT 63
#define IMAGE_VIEW_HEIGHT 67

@interface AddViewController ()

@end

@implementation AddViewController
@synthesize tableViewFields;
@synthesize scrollView;
@synthesize webView;
@synthesize buttonAdd;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        searchManager = [SearchManager sharedMySingleton];
        networkManager = [KVNetworkManager sharedInstance];
        dataManager = [KVDataManager sharedInstance];
        fields = [[searchManager findGroupByGroupType:GroupTypeMain] getObligatoryFields];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLight.png"]];
    [self.tableViewFields setBackgroundView:iv];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Добавить"];
    self.navigationItem.titleView = textLabel;
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(cleanQueryToDefaultState) frame:CGRectMake(0, 0, 39, 39) imageName:@"clean_button.png" imageNameSelected:@"clean_button_selected.png" text:nil];
    self.navigationItem.rightBarButtonItem = bbi2;
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    self.webView.delegate = self;
    
    self.viewCaptcha.backgroundColor = [UIColor clearColor];
    
    [self.buttonEnterCaptcha.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:12.]];
    self.buttonEnterCaptcha.hidden = YES;
    
    [self.buttonUpdateCaptcha.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_BOLD size:12.]];
    self.buttonUpdateCaptcha.hidden = YES;
    
    NSString *html = [NSString stringWithFormat:@"<html><body><p align=\"center\"><font size=\"2\" face=\"%@\">Нажимая кнопку \"Добавить\" я подтверждаю свое согласие с <a href=\"http://www.autochel.ru/help/car/rules\">правилами размещения объявлений</a></font></p></body></html>", FONT_DINPro_REGULAR];
    [self.webView loadHTMLString:html baseURL:nil];
    
    f0 = (AdvField *)[fields objectAtIndex:0];
    f1 = (AdvField *)[fields objectAtIndex:1];
    f2 = (AdvField *)[fields objectAtIndex:2];
    
    [(OrderedDictionary *)f0.value removeObjectForKey:@"Любой"];
    
    f0.selectedValue = [[[AdvDictionaries Cities] allKeys] objectAtIndex:0];
    f1.selectedValue = [[[AdvDictionaries Rubrics] allKeys] objectAtIndex:0];
    f2.selectedValue = [[[AdvDictionaries SubrubricsMotors] allKeys] objectAtIndex:1];
    
    isFirstAppear = YES;
}

- (void)viewDidUnload
{
    [self setTableViewFields:nil];
    [self setScrollView:nil];
    [self setWebView:nil];
    [self setButtonAdd:nil];
    [self setImageViewCaptcha:nil];
    [self setViewCaptcha:nil];
    [self setButtonEnterCaptcha:nil];
    [self setButtonUpdateCaptcha:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];
    
    [networkManager removeAllSubscribers];
    [networkManager subscribe:self];
    
    if (isFirstAppear) {
        [self cleanQueryToDefaultState];
        isFirstAppear = NO;
    }
    else {
        
        BOOL isFieldsAreRubricsAndSub = [f1.nameEnglish isEqualToString:F_RUBRIC_ENG] &&
        [f2.nameEnglish isEqualToString:F_SUBRUBRIC_ENG];
        BOOL isRubricAndSubWereSelected = f1.selectedValue != nil && f2.selectedValue != nil;
        BOOL isNeedToUpdate = [f1.selectedValue isEqualToString:lastSelectedRubric] == NO ||
                                [f2.selectedValue isEqualToString:lastSelectedSubrubric] == NO;
        
        if ([f1.selectedValue isEqualToString:lastSelectedRubric] == NO &&
            [f2.selectedValue isEqualToString:lastSelectedSubrubric] == YES) {
            f2.selectedValue = nil;
            isNeedToUpdate = NO;
        }
        
        if (f1.selectedValue != nil && f2.selectedValue == nil) {
            [self cleanQueryToDefaultStateWithoutCleaningRubAndSub];
        }
        
        if ((isFieldsAreRubricsAndSub && isNeedToUpdate) ||
            ([f1.selectedValue isEqualToString:@"Автозапчасти"])) {
            
            [self cleanQueryExceptRubricAndSubrubric];
            
            if (isRubricAndSubWereSelected == YES) {
                lastSelectedRubric = f1.selectedValue;
                lastSelectedSubrubric = f2.selectedValue;
                
                currentGroup = [searchManager categoryAddAdvertisementByRubric:f1.selectedValue subrubric:f2.selectedValue];
                fields = [currentGroup getObligatoryFields];

                [SVProgressHUD showWithStatus:PROGRESS_STATUS_PLEASE_WAIT];
                
                currentRubric = [f1 valueForServerBySelectedValue];
                currentSubrubric = [f2 valueForServerBySelectedValue];
                
                NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
                [defauls setValue:currentRubric forKey:CURRENT_RUBRIC];
                [defauls setValue:currentSubrubric forKey:CURRENT_SUBRUBRIC];
                [defauls synchronize];
                
                [networkManager getModelsByRubric:currentRubric subrubric:currentSubrubric];
            }
        }
    }
    
    if (![lastSelectedField.nameEnglish isEqualToString:F_SUBRUBRIC_ENG]) {
        [networkManager subscribe:self];
        [networkManager getCaptcha];
    }
    
    [self setFramesToViews];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [networkManager unsubscribe:self];
    [SVProgressHUD dismiss];
}


#pragma mark - Private methods

- (void)setFramesToViews
{
    self.tableViewFields.backgroundColor = [UIColor clearColor];
    CGRect tableFrame = self.tableViewFields.frame;
    CGFloat tableHeight = [fields count] * TABLE_CELL_HEIGHT;
    tableFrame.size.height = tableHeight;
    self.tableViewFields.frame = tableFrame;
    
    self.scrollView.contentSize = CGSizeMake(320,
                                             BUTTON_HEIGHT + WEB_VIEW_HEIGHT + IMAGE_VIEW_HEIGHT + tableHeight);
    
    CGRect viewFrame = self.viewCaptcha.frame;
    viewFrame.origin.y = tableHeight;
    self.viewCaptcha.frame = viewFrame;
    
    CGRect webViewFrame = self.webView.frame;
    webViewFrame.origin.y = tableHeight + IMAGE_VIEW_HEIGHT;
    self.webView.frame = webViewFrame;
    
    CGRect buttonFrame = self.buttonAdd.frame;
    buttonFrame.origin.y = tableHeight + WEB_VIEW_HEIGHT + IMAGE_VIEW_HEIGHT;
    self.buttonAdd.frame = buttonFrame;
    
    [self.tableViewFields reloadData];
}

- (void)cleanQueryToDefaultState
{
    lastSelectedRubric = nil;
    lastSelectedSubrubric = nil;

    for (AdvField *field in fields) {
        field.selectedValue = nil;
    }
    fields = [[searchManager findGroupByGroupType:GroupTypeMain] getObligatoryFields];
    
    [self setFramesToViews];
    [[KVDataManager sharedInstance] cleanAllTempData];
}

- (void)cleanQueryToDefaultStateWithoutCleaningRubAndSub
{
    lastSelectedRubric = nil;
    lastSelectedSubrubric = nil;
    
    for (AdvField *field in fields) {
        if ([field.nameEnglish isEqualToString:F_RUBRIC_ENG] == NO &&
            [field.nameEnglish isEqualToString:F_SUBRUBRIC_ENG] == NO &&
            [field.nameEnglish isEqualToString:F_CITY_CODE_ENG] == NO) {
            field.selectedValue = nil;
        }
    }
    fields = [[searchManager findGroupByGroupType:GroupTypeMain] getObligatoryFields];
    
    [self setFramesToViews];
    [[KVDataManager sharedInstance] cleanAllTempData];
}

- (void)cleanQueryExceptRubricAndSubrubric
{
    for (AdvField *field in fields) {
        if ([field.nameEnglish isEqualToString:F_RUBRIC_ENG] == NO &&
            [field.nameEnglish isEqualToString:F_SUBRUBRIC_ENG] == NO &&
            [field.nameEnglish isEqualToString:F_CITY_CODE_ENG] == NO) {
            field.selectedValue = nil;
        }
    }
    
    [self setFramesToViews];
    [[KVDataManager sharedInstance] cleanAllTempData];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    isFirstAppear = YES;
    [self cleanQueryToDefaultState];
    [self.tabBarController performSegueWithIdentifier:@"flipSegue" sender:self];
}

- (IBAction)clickOnEnterCaptchaButton:(id)sender
{
    TSAlertView* av = [[TSAlertView alloc] init];
    av.title = @"Код защиты от роботов";
    av.message = @"Введите код, который на картинке";
    [av addButtonWithTitle: @"Готово"];
    [av addButtonWithTitle: @"Отменить"];
    av.style = TSAlertViewStyleInput;
    av.buttonLayout = TSAlertViewButtonLayoutNormal;
    av.delegate = self;
    
    av.inputTextField.text = @"";
    
    [av show];
}

- (IBAction)clickOnUpdateCaptchaButton:(id)sender
{
    [networkManager getCaptcha];
}

- (IBAction)clickOnAddAdvertisementButton:(id)sender
{
    NSDictionary *dict = [searchManager parametersToAddAdvertisement:fields captchaCode:captchaCode];
    LOG(@"%@", dict);
    
    [SVProgressHUD showWithStatus:PROGRESS_STATUS_PLEASE_WAIT_ADD_ADVERTISEMENT];
    [networkManager addAdvertisementWithParameters:dict images:[dictionaryPhotos allValues]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fields count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ButtonCell";
    ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [ButtonCell loadView];
    }
    cell.delegate = self;
    
    AdvField *field = [fields objectAtIndex:indexPath.row];
    NSString *title = field.nameRussian;
    NSString *value = field.selectedValue == nil ? field.valueByDefault : field.selectedValue;
    
    if ([field.nameEnglish isEqualToString:F_PHOTO_ENG]) {
        value = [dictionaryPhotos count] != 0 ? @"Фото выбраны" : nil;
    }
    else if ([field.nameEnglish isEqualToString:F_OPTIONS_ENG]) {
        value = [dataManager.selectedOptions count] != 0 ? @"Комплектация выбрана" : nil;
    }
    else if ([field.nameEnglish isEqualToString:F_PHONE_ENG]) {
        value = [dataManager.selectedPhones count] != 0 ? @"Телефоны добавлены" : nil;
    }
    
    cell.field = field;
    
    if (field.isPrecondition) {
        if ([value length] == 0) {
            [cell setAttentionState:YES];
        }
        else {
            [cell setAttentionState:NO];
        }
    }
    
    if ([field.nameEnglish isEqualToString:F_BRAND_ENG]) {
        if (field.selectedValue == nil) {
            isBrandSelected = NO;
        }
        else {
            isBrandSelected = YES;
        }
    }
    
    if ([field.nameEnglish isEqualToString:F_MODEL_ENG]) {
        cell.button.enabled = isBrandSelected;
    }
    
    [cell.textView setText:title];
    [cell.button setTitle:value forState:UIControlStateNormal];
    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lastSelectedField = [fields objectAtIndex:indexPath.row];
    
    if (lastSelectedField.valueType == ValueTypePhoto) {
        SelectValuePhotoViewController *photoVC = [[SelectValuePhotoViewController alloc] initWithNibName:@"SelectValuePhotoViewController" bundle:nil];
        photoVC.labelName = lastSelectedField.nameRussian;
        photoVC.selectedPhotos = dictionaryPhotos;
        photoVC.delegate = self;
        [self.navigationController pushViewController:photoVC animated:YES];
    }
    else {
        BOOL isOpenNewVC = NO;
        if ([lastSelectedField.nameEnglish isEqualToString:F_MODEL_ENG]) {
            if (isBrandSelected) {
                isOpenNewVC = YES;
            }
        }
        else {
            isOpenNewVC = YES;
        }
        
        if (isOpenNewVC) {
            Search2ViewController *search2VC = [Search2ViewController new];
            search2VC.typeOfSearch2ViewController = Search2ViewControllerTypeAddAdvertisement;
            search2VC.field = lastSelectedField;
            [self.navigationController pushViewController:search2VC animated:YES];
        }
    }
}


#pragma mark - @protocol SelectValueDelegate <NSObject>

- (void)valueWasSelected:(id)selectedValue
{
    OrderedDictionary *selectedPhotos = (OrderedDictionary *)selectedValue;
    if ([selectedPhotos count] != 0) {
        lastSelectedField.selectedValue = @"Фото выбраны";
    }
    else {
        lastSelectedField.selectedValue = nil;
    }
    dictionaryPhotos = (OrderedDictionary *)selectedValue;
}


#pragma mark - @protocol UIAlertViewDelegate <NSObject>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView isKindOfClass:[TSAlertView class]]) {
        // cancel
        if (buttonIndex == 1) {
            return;
        }
        else {
            captchaCode = ((TSAlertView *)alertView).inputTextField.text;
        }
    }
    else {
        if (buttonIndex == 0) {
            [networkManager unsubscribe:self];
            [SVProgressHUD showSuccessWithStatus:PROGRESS_STATUS_SUCCESS];
        }
    }
}


#pragma mark - @protocol UIWebViewDelegate <NSObject>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSString *url = [[request URL] absoluteString];
        AdvertisementWebViewController *vc = [[AdvertisementWebViewController alloc] initWithNibName:@"AdvertisementWebViewController" bundle:nil];
        vc.URLString = url;
        vc.titleString = @"Правила размещения";
        [self.navigationController pushViewController:vc animated:YES];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - @protocol KVNetworkDelegate

- (void)requestProcessed:(RequestType)requestId forId:(NSString *)identifier
{
    if (requestId == RequestTypeBrands) {
        [networkManager getOptionsByRubric:currentRubric subrubric:currentSubrubric];
    }
    else if (requestId == RequestTypeOptions) {
        [networkManager getCaptcha];
        [SVProgressHUD showSuccessWithStatus:PROGRESS_STATUS_SUCCESS];
    }
    else if (requestId == RequestTypeAddAdvertisement) {
        [SVProgressHUD showSuccessWithStatus:PROGRESS_STATUS_SUCCESS_ADD_ADVERTISEMENT];
        [self cleanQueryToDefaultState];
        [self performSelector:@selector(goBack:) withObject:nil afterDelay:1.0];
    }
    else if (requestId == RequestTypeGetCaptcha) {
        UIImage *placeholderImage = [UIImage imageWithContentsOfFile:PATH_TO_CAPTCHA_IMAGE];
        [self.imageViewCaptcha setImage:placeholderImage];
        
        self.buttonEnterCaptcha.hidden = NO;
        self.buttonUpdateCaptcha.hidden = NO;
    }
}

- (void)requestFailed:(RequestType)requestId forId:(NSString *)identifier error:(NSString *)message code:(int)code
{
    [SVProgressHUD showErrorWithStatus:message];
    LOG(@"request %d with id %@ was failed with error %@", requestId, identifier, message);
}


#pragma mark - @protocol ButtonCellDelegate <NSObject>

- (void)userClickedOnAttentionButton:(AdvField *)field
{
    OLGhostAlertView *alert = [[OLGhostAlertView alloc] initWithTitle:@"" message:field.attentionText timeout:2 dismissible:YES];
    [alert show];
}

@end
