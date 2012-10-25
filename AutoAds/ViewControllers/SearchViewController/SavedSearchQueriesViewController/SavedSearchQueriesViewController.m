//
//  SavedSearchQueriesViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SavedSearchQueriesViewController.h"

@interface SavedSearchQueriesViewController ()

@end

@implementation SavedSearchQueriesViewController
@synthesize tableViewSavedSearchQueries;
@synthesize buttonNewSearch;
@synthesize viewHeader;


#pragma mark - Initialization

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        databaseManager = [DatabaseManager sharedMySingleton];
        networkManager = [KVNetworkManager sharedInstance];
        dataManager = [KVDataManager sharedInstance];
        
        latestSearchQueries = [NSMutableArray new];
        savedSearchQueries = [NSMutableArray new];
        
        currentQueryString = [KVPair new];
    }
    return self;
}


#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [viewHeader setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"hugeHeader.png"]]];
    [buttonNewSearch.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:16.]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Поиск"];
    self.navigationItem.titleView = textLabel;
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = bbi;
    
    self.tableViewSavedSearchQueries.backgroundColor = [UIColor clearColor];
    
//    [[KVNetworkManager sharedInstance] getModelsByRubric:@"motors" subrubric:@"foreign"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resetDataSourceOfTableView];
    [self.tableViewSavedSearchQueries reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [networkManager unsubscribe:self];
    [SVProgressHUD dismiss];
}

- (void)viewDidUnload
{
    [self setButtonNewSearch:nil];
    [self setViewHeader:nil];
    [self setTableViewSavedSearchQueries:nil];
    [super viewDidUnload];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.tabBarController performSegueWithIdentifier:@"flipSegue" sender:self];
}

- (IBAction)clickOnNewSearchButton:(id)sender
{
    [SVProgressHUD showWithStatus:PROGRESS_STATUS_PLEASE_WAIT];
    
    [self performSelector:@selector(showSearchViewController) withObject:nil afterDelay:0.3];
    
}

- (void)showSearchViewController
{
    SearchViewController *vc = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Private methods

- (void)resetDataSourceOfTableView
{
    NSArray *queriesLastest = [databaseManager getQueries:NO];
    NSArray *queriesSaved = [databaseManager getQueries:YES];
    [latestSearchQueries removeAllObjects];
    [savedSearchQueries removeAllObjects];
    [latestSearchQueries addObjectsFromArray:queriesLastest];
    [savedSearchQueries addObjectsFromArray:queriesSaved];
    
    [[NSUserDefaults standardUserDefaults] setInteger:[savedSearchQueries count] forKey:COUNT_OF_NEW_ADVERTISEMENTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [dataManager.advCountDictionary removeAllObjects];
    
    [networkManager subscribe:self];
    for (int i = 0; i < [savedSearchQueries count]; i++) {
        Query *query = [savedSearchQueries objectAtIndex:i];
        [networkManager countOfNewAdvertisementsByQuery:query.queryString lastDate:query.dateAdded indexOfQuery:i];
    }
}


#pragma mark - @protocol UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [latestSearchQueries count];
    }
    return [savedSearchQueries count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Query *query = nil;
        if (indexPath.section == 0) {
            query = [latestSearchQueries objectAtIndex:indexPath.row];
        }
        else {
            query = [savedSearchQueries objectAtIndex:indexPath.row];
        }
        [databaseManager deleteEntity:query];
        [self resetDataSourceOfTableView];
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ButtonCell";
    SavedSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [SavedSearchCell loadView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 1) {
        NSString *index = [NSString stringWithFormat:@"%d", indexPath.row];
        NSString *count = [dataManager.advCountDictionary valueForKey:index];
        
        if ([count length] != 0) {
            cell.labelCount.text = [NSString stringWithFormat:@"(%@)", count];
        }
    }
    else {
        cell.labelCount.hidden = YES;
    }
    
    Query *query = nil;
    if (indexPath.section == 0) {
        query = [latestSearchQueries objectAtIndex:indexPath.row];
    }
    else {
        query = [savedSearchQueries objectAtIndex:indexPath.row];
    }
    
    
    NSDictionary *values = [KVPair valuesByThisString:query.queryStringRussian];
    LOG(@"values - %@", values);
    
    // configure first line
    NSString *city = [values valueForKey:F_CITY_CODE_RUS];
    NSString *rubric = [values valueForKey:F_RUBRICID_RUS];
    NSString *brand = [values valueForKey:F_BRAND_RUS];
    if (brand == nil) {
        brand = @"";
    }
    
    NSString *firstLine = [NSString stringWithFormat:@"%@  %@  %@", city, rubric, brand];
    
    // configure second line
    NSMutableString *secondLine = [NSMutableString new];
    for (int i = 0; i < [values count]; i++) {
        NSString *key = [[values allKeys] objectAtIndex:i];
        NSString *value = [values valueForKey:key];
        
        if (i == 0) {
            [secondLine appendFormat:@"%@ - %@", key, value];
        }
        else {
            [secondLine appendFormat:@", %@ - %@", key, value];
        }
    }
    
    [cell.labelBig setText:firstLine];
    [cell.labelSmall setText:secondLine];
    
    return cell;
}


#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableViewHeader *tableViewHeader = [TableViewHeader loadView];
    if (section == 0) {
        tableViewHeader.labelTitle.text = @"Последние";
    }
    else if (section == 1) {
        tableViewHeader.labelTitle.text = @"Сохраненные";
    }
    
    return tableViewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 27;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Query *query = nil;
    if (indexPath.section == 0) {
        query = [latestSearchQueries objectAtIndex:indexPath.row];
    }
    else {
        query = [savedSearchQueries objectAtIndex:indexPath.row];
    }
    currentQueryString.queryEnglish = query.queryString;
    currentQueryString.queryRussian = query.queryStringRussian;
    
    // update last searched date
    query.dateAdded = [NSDate date];
    [databaseManager saveAll];
    
    [networkManager subscribe:self];
    [networkManager searchWithQuery:currentQueryString.queryEnglish isSearchWithPage:NO];
    
    [SVProgressHUD showWithStatus:PROGRESS_STATUS_PLEASE_WAIT];
//    pleaseWaitAlertView = [[PleaseWaitAlertView alloc] initWithTitle:nil message:@"Пожалуйста, подождите...\n\n\n" delegate:self cancelButtonTitle:@"Отменить" otherButtonTitles: nil];
//    [pleaseWaitAlertView show];
}


#pragma mark - @protocol KVNetworkDelegate

- (void)requestProcessed:(RequestType)requestId forId:(NSString *)identifier
{
    [SVProgressHUD showSuccessWithStatus:PROGRESS_STATUS_SUCCESS];
//    [pleaseWaitAlertView dismissWithClickedButtonIndex:-1 animated:YES];
    
    if (requestId == RequestTypeSearch) {
        ListOfAdverisementViewController *vc = [[ListOfAdverisementViewController alloc] initWithNibName:@"ListOfAdverisementViewController" bundle:nil];
        vc.queryString = currentQueryString;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (requestId == RequestTypeSearchNew) {
        [self.tableViewSavedSearchQueries reloadData];
    }
}

- (void)requestFailed:(RequestType)requestId forId:(NSString *)identifier error:(NSString *)message code:(int)code
{
    LOG(@"request %d with id %@ was failed with error %@", requestId, identifier, message);
}

@end
