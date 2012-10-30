//
//  MoreViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "MoreViewController.h"

#define TABLE_HEADER_HEIGHT 27
#define TABLE_CELL_HEIGHT 68
#define BUTTON_HEIGHT 63

@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize scrollView;
@synthesize tableViewLinks;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        dictionaryLinks = [AdvDictionaries OurProjects];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Еще"];
    self.navigationItem.titleView = textLabel;
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = bbi;
    
    self.tableViewLinks.backgroundColor = [UIColor clearColor];
    CGRect tableFrame = self.tableViewLinks.frame;
    CGFloat tableHeight = [dictionaryLinks count] * TABLE_CELL_HEIGHT + TABLE_HEADER_HEIGHT;
    tableFrame.size.height = tableHeight;
    self.tableViewLinks.frame = tableFrame;
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(320,
                                             2 * BUTTON_HEIGHT + tableHeight);
}

- (void)viewDidUnload
{
    [self setTableViewLinks:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [SVProgressHUD dismiss];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.tabBarController performSegueWithIdentifier:@"flipSegue" sender:self];
}

- (IBAction)clickOnTechnicalHelpButton:(id)sender
{
    TechnicalHelpViewController *vc = [[TechnicalHelpViewController alloc] initWithNibName:@"TechnicalHelpViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickOnAboutProgramButton:(id)sender
{
    AboutProgramViewController *vc = [[AboutProgramViewController alloc] initWithNibName:@"AboutProgramViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - @protocol UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dictionaryLinks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ButtonCell";
    LinkCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [LinkCell loadView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *link = [[dictionaryLinks allKeys] objectAtIndex:indexPath.row];
    NSString *name = [dictionaryLinks valueForKey:link];
    
    [cell.labelName setText:link];
    [cell.labelLink setText:name];
    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *URLString = [[dictionaryLinks allValues] objectAtIndex:indexPath.row];
    NSString *URLName = [[dictionaryLinks allKeys] objectAtIndex:indexPath.row];
    
    AdvertisementWebViewController *vc = [[AdvertisementWebViewController alloc] initWithNibName:@"AdvertisementWebViewController" bundle:nil];
    vc.titleString = URLName;
    vc.URLString = URLString;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableViewHeader *tableViewHeader = [TableViewHeader loadView];
    tableViewHeader.labelTitle.text = @"Другие наши проекты";
    
    return tableViewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_HEADER_HEIGHT;
}
@end
