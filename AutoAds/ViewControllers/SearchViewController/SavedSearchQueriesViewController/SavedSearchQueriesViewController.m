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
        latestSearchQueries = [NSMutableArray new];
        [latestSearchQueries addObject:@"Mazda 3 [2] -- 650-270 тыс./руб., 2011г., >100000 км."];
        
        savedSearchQueries = [NSMutableArray new];
        [savedSearchQueries addObject:@"Lada Priora [7] -- 150-270 тыс./руб., 2011г., >100000 км."];
        [savedSearchQueries addObject:@"Lada Priora [9] -- 250-270 тыс./руб., 2011г., >100000 км."];
        [savedSearchQueries addObject:@"Lada Priora [19] -- 350-270 тыс./руб., 2011г., >100000 км."];
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
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    self.tableViewSavedSearchQueries.backgroundColor = [UIColor clearColor];
    
//    [[KVNetworkManager sharedInstance] getModelsByRubric:@"motors" subrubric:@"foreign"];
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
    SearchViewController *vc = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
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
        if (indexPath.section == 0) {
            [latestSearchQueries removeObjectAtIndex:indexPath.row];
        }
        else {
            [savedSearchQueries removeObjectAtIndex:indexPath.row];
        }
        
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
    
    NSArray *adv = nil;
    if (indexPath.section == 0) {
        adv = [[latestSearchQueries objectAtIndex:indexPath.row] componentsSeparatedByString:@" -- "];
    }
    else {
        adv = [[savedSearchQueries objectAtIndex:indexPath.row] componentsSeparatedByString:@" -- "];
    }
    [cell.labelBig setText:[adv objectAtIndex:0]];
    [cell.labelSmall setText:[adv objectAtIndex:1]];
    
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

}

@end
