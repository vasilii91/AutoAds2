//
//  SearchViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SearchViewController.h"
#import "CellHeightProtocol.h"

#import "ButtonCell.h"
#import "RubrikCell.h"

#define CITY 0
#define TYPE 2
#define ORIGIN 4
#define MODEL 6
#define PRICE 8
#define YEAR 10;

@interface SearchViewController ()

@end

@implementation SearchViewController
{
    
}

@synthesize tableView = _tableView;


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        searchManager = [SearchManager sharedMySingleton];
        networkManager = [KVNetworkManager sharedInstance];
        dataManager = [KVDataManager sharedInstance];
        fields = [[searchManager findGroupByGroupType:GroupTypeMain] getObligatoryFields];
    }
    return self;
}


#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLight.png"]];
    [self.tableView setBackgroundView:iv];
    [_searchButton.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:16.]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Поиск"];
    self.navigationItem.titleView = textLabel;
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" imageNameSelected:@"backButton.png"  text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(cleanQueryToDefaultState) frame:CGRectMake(0, 0, 39, 39) imageName:@"clean_button.png" imageNameSelected:@"clean_button_selected.png" text:nil];
    self.navigationItem.rightBarButtonItem = bbi2;
    
    f0 = (AdvField *)[fields objectAtIndex:0];
    f1 = (AdvField *)[fields objectAtIndex:1];
    f2 = (AdvField *)[fields objectAtIndex:2];
    f0.selectedValue = [[[AdvDictionaries Cities] allKeys] objectAtIndex:0];
    f1.selectedValue = [[[AdvDictionaries Rubrics] allKeys] objectAtIndex:0];
    f2.selectedValue = [[[AdvDictionaries SubrubricsMotors] allKeys] objectAtIndex:1];
    
    currentGroup = [searchManager categorySearchByRubric:f1.selectedValue subrubric:f2.selectedValue];
    fields = [currentGroup getObligatoryFields];
    
    [self cleanQueryExceptRubricAndSubrubric];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];
    [networkManager subscribe:self];
    
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
            
            currentGroup = [searchManager categorySearchByRubric:f1.selectedValue subrubric:f2.selectedValue];
            fields = [currentGroup getObligatoryFields];
            
//            pleaseWaitAlertView = [[PleaseWaitAlertView alloc] initWithTitle:nil message:@"Пожалуйста, подождите...\n\n\n" delegate:self cancelButtonTitle:@"Отменить" otherButtonTitles: nil];
//            [pleaseWaitAlertView show];
            
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
    
    [self.tableView reloadData];
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

- (void)reloadData
{
    [self.tableView reloadData];
    [[KVDataManager sharedInstance] cleanAllTempData];
}

- (void)cleanQueryToDefaultState
{
    lastSelectedRubric = nil;
    lastSelectedSubrubric = nil;
    
    for (AdvField *field in fields) {
        field.selectedValue = nil;
    }
    fields = [[searchManager findGroupByGroupType:GroupTypeMain] getObligatoryFields];
    
    [self reloadData];
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
    
    [self reloadData];
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
    
    [self reloadData];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickOnSearchButton:(id)sender
{
    queryString = [searchManager queryToSearch:fields];
    [networkManager searchWithQuery:queryString.queryEnglish isSearchWithPage:NO];
    
//    [pleaseWaitAlertView show];
    [SVProgressHUD showWithStatus:PROGRESS_STATUS_PLEASE_WAIT];
}


#pragma mark - @protocol UIAlertViewDelegate <NSObject>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [networkManager unsubscribe:self];
//        [pleaseWaitAlertView dismissWithClickedButtonIndex:-1 animated:YES];
        [SVProgressHUD showSuccessWithStatus:PROGRESS_STATUS_SUCCESS];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fields count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <CellHeightProtocol> cell = (id)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
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
    
    if ([field.nameEnglish isEqualToString:F_MODEL_ENG]) {
        value = [dataManager.selectedModels count] != 0 ? @"Модели выбраны" : nil;
    }
    else if ([field.nameEnglish isEqualToString:F_FUEL_ENG]) {
        value = [dataManager.selectedFuels count] != 0 ? @"Топливо выбрано" : nil;
    }
    else if ([field.nameEnglish isEqualToString:F_STATES_ENG]) {
        value = [dataManager.selectedStates count] != 0 ? @"Состояния выбраны" : nil;
    }
    else if ([field.nameEnglish isEqualToString:F_OPTIONS_ENG]) {
        value = [dataManager.selectedOptions count] != 0 ? @"Комплектация выбрана" : nil;
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
    [cell setAttentionState:NO];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lastSelectedField = [fields objectAtIndex:indexPath.row];
    
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
        search2VC.typeOfSearch2ViewController = Search2ViewControllerTypeSearch;
        search2VC.field = lastSelectedField;
        [self.navigationController pushViewController:search2VC animated:YES];
    }
}


#pragma mark - @protocol KVNetworkDelegate

- (void)requestProcessed:(RequestType)requestId forId:(NSString *)identifier
{
//    [pleaseWaitAlertView dismissWithClickedButtonIndex:-1 animated:YES];
    [SVProgressHUD showSuccessWithStatus:PROGRESS_STATUS_SUCCESS];
    
    if (requestId == RequestTypeSearch) {
        [networkManager getOptionsByRubric:currentRubric subrubric:currentSubrubric];
    }
    else if (requestId == RequestTypeOptions) {
        ListOfAdverisementViewController *vc = [[ListOfAdverisementViewController alloc] initWithNibName:@"ListOfAdverisementViewController" bundle:nil];
        vc.queryString = queryString;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
    }
}

- (void)requestFailed:(RequestType)requestId forId:(NSString *)identifier error:(NSString *)message code:(int)code
{
    LOG(@"request %d with id %@ was failed with error %@", requestId, identifier, message);
    [SVProgressHUD showErrorWithStatus:PROGRESS_STATUS_ERROR];
}

@end
