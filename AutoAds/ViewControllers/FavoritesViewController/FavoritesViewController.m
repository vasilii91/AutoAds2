//
//  FavoritesViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController
@synthesize tableViewFavorites;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Избранное"];
    self.navigationItem.titleView = textLabel;
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    self.tableViewFavorites.backgroundColor = [UIColor clearColor];
}

- (void)viewDidUnload
{
    [self setTableViewFavorites:nil];
    [super viewDidUnload];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.tabBarController performSegueWithIdentifier:@"flipSegue" sender:self];
}

#pragma mark - @protocol UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ButtonCell";
    AdvertisementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [AdvertisementCell loadView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.isShowFavoriteButton = YES;
    cell.cellIndex = indexPath.row;
    cell.delegate = self;
    
    [cell.labelCarName setText:@"Shoda Oktavia"];
    [cell.labelPrice setText:@"250 000 руб."];
    [cell.labelOtherInfo setText:@"2008 г., 243000 км., седан"];

    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdvertisementViewController *avc = [[AdvertisementViewController alloc] initWithNibName:@"AdvertisementViewController" bundle:nil];
    [self.navigationController pushViewController:avc animated:YES];
}


#pragma mark - @protocol AdvertisementCellProtocol <NSObject>

- (void)userClickedOnFavoriteButtonWithIndex:(NSInteger)cellIndex
{
    LOG(@"%d", cellIndex);
}

@end
