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
        [networkManager subscribe:self];
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
    [_header setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"hugeHeader.png"]]];
    [_searchButton.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:16.]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Поиск"];
    self.navigationItem.titleView = textLabel;
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(cleanQueryToDefaultState) frame:CGRectMake(0, 0, 39, 39) imageName:@"addBarIcon.png" text:nil];
    self.navigationItem.rightBarButtonItem = bbi2;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AdvField *f1 = (AdvField *)[fields objectAtIndex:1];
    AdvField *f2 = (AdvField *)[fields objectAtIndex:2];
    
    BOOL isFieldsAreRubricsAndSub = [f1.nameEnglish isEqualToString:F_RUBRIC_ENG] &&
                                    [f2.nameEnglish isEqualToString:F_SUBRUBRIC_ENG];
    BOOL isRubricAndSubWereSelected = f1.selectedValue != nil && f2.selectedValue != nil;
    BOOL isNeedToUpdate = [f1.selectedValue isEqualToString:lastSelectedRubric] == NO ||
                            [f2.selectedValue isEqualToString:lastSelectedSubrubric] == NO;
    
    if (f1.selectedValue != nil && f2.selectedValue == nil) {
        [self cleanQueryToDefaultStateWithoutCleaningRubAndSub];
    }
    
    if ((isFieldsAreRubricsAndSub && isNeedToUpdate) ||
        ([f1.selectedValue isEqualToString:@"Автозапчасти"])) {
        
        [self cleanQueryExceptRubricAndSubrubric];
        
        if (isRubricAndSubWereSelected == YES) {
            lastSelectedRubric = f1.selectedValue;
            lastSelectedSubrubric = f2.selectedValue;
            
            currentGroup = [searchManager categoryByRubric:f1.selectedValue subrubric:f2.selectedValue];
            fields = [currentGroup getObligatoryFields];
            
            pleaseWaitAlertView = [[PleaseWaitAlertView alloc] initWithTitle:nil message:@"Пожалуйста, подождите..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [pleaseWaitAlertView show];
            
            NSString *rubric = [f1 valueForServerBySelectedValue];
            NSString *subrubric = [f2 valueForServerBySelectedValue];
            
            [networkManager getModelsByRubric:rubric subrubric:subrubric];
        }
    }
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark - Private methods

- (void)cleanQueryToDefaultState
{
    for (AdvField *field in fields) {
        field.selectedValue = nil;
    }
    fields = [[searchManager findGroupByGroupType:GroupTypeMain] getObligatoryFields];
    
    [self.tableView reloadData];
}

- (void)cleanQueryToDefaultStateWithoutCleaningRubAndSub
{
    for (AdvField *field in fields) {
        if ([field.nameEnglish isEqualToString:F_RUBRIC_ENG] == NO &&
            [field.nameEnglish isEqualToString:F_SUBRUBRIC_ENG] == NO &&
            [field.nameEnglish isEqualToString:F_CITY_CODE_ENG] == NO) {
            field.selectedValue = nil;
        }
    }
    fields = [[searchManager findGroupByGroupType:GroupTypeMain] getObligatoryFields];
    
    [self.tableView reloadData];
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
    
    [self.tableView reloadData];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickOnSearchButton:(id)sender
{
    ListOfAdverisementViewController *vc = [[ListOfAdverisementViewController alloc] initWithNibName:@"ListOfAdverisementViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - @protocol ButtonCellDelegate <NSObject>

- (void)didTapButtonInButtonCell:(ButtonCell *)cell
{
    
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
    
    [cell.textView setText:title];
    [cell.button setTitle:value forState:UIControlStateNormal];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lastSelectedField = [fields objectAtIndex:indexPath.row];
    
    Search2ViewController *search2VC = [Search2ViewController new];
    search2VC.field = lastSelectedField;
    [self.navigationController pushViewController:search2VC animated:YES];
}


#pragma mark - @protocol KVNetworkDelegate

- (void)requestProcessed:(int)requestId forId:(NSString *)identifier
{
    [pleaseWaitAlertView dismissWithClickedButtonIndex:-1 animated:YES];
    pleaseWaitAlertView = nil;
}

- (void)requestFailed:(int)requestId forId:(NSString *)identifier error:(NSString *)message code:(int)code
{
    LOG(@"request %d with id %@ was failed with error %@", requestId, identifier, message);
}

@end
