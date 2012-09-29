//
//  ListOfAdverisementViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "ListOfAdverisementViewController.h"

#define SORT_BUTTON_IMAGE_SELECTED @"moreBlue.png"
#define SORT_BUTTON_IMAGE_DESELECTED @"moreBarIcon.png"

#define SAVE_BUTTON_IMAGE_SELECTED @"addBlue.png"
#define SAVE_BUTTON_IMAGE_DESELECTED @"addBarIcon.png"

@interface ListOfAdverisementViewController ()

@end

@implementation ListOfAdverisementViewController
@synthesize tableViewAdvertisement;


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dataManager = [KVDataManager sharedInstance];
        
        searchedAdvertisements = [dataManager advertisements];
    }
    return self;
}


#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Список"];
    self.navigationItem.titleView = textLabel;
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(clickOnSortButton:) frame:CGRectMake(0, 0, 33, 33) imageName:SORT_BUTTON_IMAGE_DESELECTED text:nil];
    UIBarButtonItem *bbi3 = [PrettyViews backBarButtonWithTarget:self action:@selector(clickOnSaveButton:) frame:CGRectMake(0, 0, 33, 33) imageName:SAVE_BUTTON_IMAGE_DESELECTED text:nil];
    self.navigationItem.rightBarButtonItems = @[bbi2, bbi3];
    
    self.tableViewAdvertisement.backgroundColor = [UIColor clearColor];
    
    listOfAdvertisementHeader = [ListOfAdvertisementHeader loadView];
    listOfAdvertisementHeader.delegate = self;
    CGRect rect = listOfAdvertisementHeader.frame;
    frameOfHeaderWhenHidden = CGRectMake(0,
                                         -rect.size.height,
                                         rect.size.width,
                                         rect.size.height);
    frameOfHeaderWhenShown = CGRectMake(0,
                                        0,
                                        rect.size.width,
                                        rect.size.height);
    
    [listOfAdvertisementHeader setFrame:frameOfHeaderWhenHidden];
    
    frameOfTableViewWhenShown = self.tableViewAdvertisement.frame;
    
    frameOfTableViewWhenHidden = CGRectMake(0,
                                            frameOfHeaderWhenShown.size.height,
                                            self.tableViewAdvertisement.frame.size.width,
                                            self.tableViewAdvertisement.frame.size.height - frameOfHeaderWhenShown.size.height);
    
    [self.view addSubview:listOfAdvertisementHeader];
    
//    // setup the pull-to-refresh view
//    [self.tableViewAdvertisement addPullToRefreshWithActionHandler:^{
//        NSLog(@"refresh dataSource");
//        if (tableViewAdvertisement.pullToRefreshView.state == SVPullToRefreshStateLoading)
//            NSLog(@"Pull to refresh is loading");
//        [tableViewAdvertisement.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
//    }];
    
    [self.tableViewAdvertisement addInfiniteScrollingWithActionHandler:^{
//        NSLog(@"load more data");
//        NSArray *arr = [dataManager advertisements];
//        [searchedAdvertisements addObjectsFromArray:arr];
//        [self.tableViewAdvertisement reloadData];
    }];
    
    // you can also display the "last updated" date
    tableViewAdvertisement.pullToRefreshView.lastUpdatedDate = [NSDate date];
}

- (void)viewDidUnload
{
    [self setTableViewAdvertisement:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickOnSortButton:(UIButton *)button
{
    isShowHeader = !isShowHeader;
    
    if (isShowHeader) {
        [button setBackgroundImage:[UIImage imageNamed:SORT_BUTTON_IMAGE_SELECTED] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            [listOfAdvertisementHeader setFrame:frameOfHeaderWhenShown];
            [self.tableViewAdvertisement setFrame:frameOfTableViewWhenHidden];
        }];
        
    }
    else {
        [button setBackgroundImage:[UIImage imageNamed:SORT_BUTTON_IMAGE_DESELECTED] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            [listOfAdvertisementHeader setFrame:frameOfHeaderWhenHidden];
            [self.tableViewAdvertisement setFrame:frameOfTableViewWhenShown];
        }];
    }
}

- (void)clickOnSaveButton:(UIButton *)button
{
    isSaved = !isSaved;
    if (isSaved) {
        [button setBackgroundImage:[UIImage imageNamed:SAVE_BUTTON_IMAGE_SELECTED] forState:UIControlStateNormal];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Сохранение"
                                                        message:@"Ваш поисковой запрос сохранен"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles: nil];
        [alert show];
    }
    else {
        [button setBackgroundImage:[UIImage imageNamed:SAVE_BUTTON_IMAGE_DESELECTED] forState:UIControlStateNormal];
    }
}


#pragma mark - Private methods

- (void)sortAdvertisementsBySortType:(TypeOfSort)sortType
{
    NSComparisonResult (^sortBlock)(id, id) = ^(id obj1, id obj2) {
        
        Advertisement *adv1 = (Advertisement *)obj1;
        Advertisement *adv2 = (Advertisement *)obj2;
        
        NSComparisonResult result;
        if (sortType == TypeOfSortByPriceAscending ||
            sortType == TypeOfSortByPriceDescending) {
            
            NSInteger price1 = [adv1.Price integerValue];
            NSInteger price2 = [adv2.Price integerValue];
            
            result = NSOrderedSame;
            if (price1 > price2) {
                result = NSOrderedAscending;
            }
            else if (price1 < price2) {
                result = NSOrderedDescending;
            }
        }
        else {
            result = [[adv1 getDateCreated] compare:[adv2 getDateCreated]];
        }
        
        if (sortType == TypeOfSortByDateDescending ||
            sortType == TypeOfSortByPriceDescending) {
            
            if (result == NSOrderedAscending) {
                result = NSOrderedDescending;
            }
            else if (result == NSOrderedDescending) {
                result = NSOrderedAscending;
            }
        }
        
        return result;
    };
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithArray:[searchedAdvertisements sortedArrayUsingComparator:sortBlock]];
    [searchedAdvertisements removeAllObjects];
    [searchedAdvertisements addObjectsFromArray:sortedArray];
    
    [self.tableViewAdvertisement reloadData];
}


#pragma mark - @protocol UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchedAdvertisements count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ButtonCell";
    AdvertisementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [AdvertisementCell loadView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Advertisement *adv = [searchedAdvertisements objectAtIndex:indexPath.row];
    NSURL *photoSmallURL = [NSURL URLWithString:[[[adv.Photo objectAtIndex:0] small] url]];
    
    [cell.labelCarName setText:adv.Name];
    [cell.labelPrice setText:adv.getCarPrice];
    [cell.labelOtherInfo setText:adv.getOtherInfo];
    [cell.imageViewPhoto setImageWithURL:photoSmallURL placeholderImage:[UIImage imageNamed:@"thumbnail_02.png"]];
    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Advertisement *advertisement = [searchedAdvertisements objectAtIndex:indexPath.row];
    
    AdvertisementViewController *avc = [[AdvertisementViewController alloc] initWithNibName:@"AdvertisementViewController" bundle:nil];
    avc.advertisement = advertisement;
    [self.navigationController pushViewController:avc animated:YES];
}


#pragma mark - @protocol ListOfAdvertisementHeaderProtocol <NSObject>

- (void)userChoosenTypeOfSort:(TypeOfSort)typeOfSort
{
    [self sortAdvertisementsBySortType:typeOfSort];
}


@end
