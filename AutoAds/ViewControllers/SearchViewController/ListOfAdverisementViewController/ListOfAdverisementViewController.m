//
//  ListOfAdverisementViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "ListOfAdverisementViewController.h"

#define SORT_BUTTON_IMAGE_SELECTED @"list_button_selected.png"
#define SORT_BUTTON_IMAGE_DESELECTED @"list_button.png"

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
        databaseManager = [DatabaseManager sharedMySingleton];
        networkManager = [KVNetworkManager sharedInstance];
        searchManager = [SearchManager sharedMySingleton];
        searchedAdvertisements = [dataManager advertisements];
    }
    return self;
}


#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentPage = 2;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Список"];
    self.navigationItem.titleView = textLabel;
    
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(clickOnSortButton:) frame:CGRectMake(0, 0, 33, 33) imageName:SORT_BUTTON_IMAGE_DESELECTED imageNameSelected:SORT_BUTTON_IMAGE_DESELECTED text:nil];
    UIBarButtonItem *bbi3 = [PrettyViews backBarButtonWithTarget:self action:@selector(clickOnSaveButton:) frame:CGRectMake(0, 0, 33, 33) imageName:SAVE_BUTTON_IMAGE_DESELECTED imageNameSelected:SAVE_BUTTON_IMAGE_DESELECTED text:nil];
    self.navigationItem.rightBarButtonItems = @[bbi2, bbi3];
    
    [self setStateToSaveButton:(UIButton *)bbi3.customView];
    [self saveQuery:NO];
    
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
        if ((currentPage - 1) * COUNT_ON_PAGE < dataManager.totalCount) {
            [networkManager subscribe:self];
            NSString *qStr = [NSString stringWithFormat:@"%@&page=%d", self.queryString, currentPage];
            [networkManager searchWithQuery:qStr isSearchWithPage:YES];
        }
        else {
            [self.tableViewAdvertisement setShowsInfiniteScrolling:NO];
        }
    }];
    
    // you can also display the "last updated" date
    tableViewAdvertisement.pullToRefreshView.lastUpdatedDate = [NSDate date];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [networkManager unsubscribe:self];
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
    Query *query = [databaseManager findQueryByQueryString:self.queryString.queryEnglish isSaved:YES];
    
    isSaved = (query == nil) ? NO : YES;
    
    if (!isSaved) {
        [self saveQuery:YES];
        
        [SVProgressHUD showSuccessWithStatus:@"Ваш поисковой запрос сохранен"];
    }
    else {
        [databaseManager deleteEntity:query];
        
        [SVProgressHUD showErrorWithStatus:@"Ваш поисковой запрос удален"];
    }
    
    [self setStateToSaveButton:button];
}


#pragma mark - Private methods

- (void)saveQuery:(BOOL)_isSaved
{
    Query *query = (Query *)[databaseManager createEntityByClass:[Query class]];
    query.dateAdded = [NSDate date];
    query.isSaved = @(_isSaved);
    query.queryString = self.queryString.queryEnglish;
    query.queryStringRussian = self.queryString.queryRussian;
    [databaseManager saveAll];
}

- (void)setStateToSaveButton:(UIButton *)button
{
    Query *query = [databaseManager findQueryByQueryString:self.queryString.queryEnglish isSaved:YES];
    
    isSaved = (query == nil) ? NO : YES;
    
    if (isSaved) {
        [button setBackgroundImage:[UIImage imageNamed:SAVE_BUTTON_IMAGE_SELECTED] forState:UIControlStateNormal];
    }
    else {
        [button setBackgroundImage:[UIImage imageNamed:SAVE_BUTTON_IMAGE_DESELECTED] forState:UIControlStateNormal];
    }
}

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
    [cell setIsShowFavoriteButton:NO];
    
    Advertisement *adv = [searchedAdvertisements objectAtIndex:indexPath.row];
    NSURL *photoSmallURL = [NSURL URLWithString:[[[adv.Photo objectAtIndex:0] small] url]];
    NSString *otherInfo = [adv getAdvertisementInfo];
    
    [cell.labelCarName setText:adv.Name];
    [cell.labelPrice setText:adv.getCarPrice];
    [cell.labelOtherInfo setText:otherInfo];
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


#pragma mark - @protocol KVNetworkDelegate

- (void)requestProcessed:(RequestType)requestId forId:(NSString *)identifier
{
    [networkManager unsubscribe:self];
    [self.tableViewAdvertisement setShowsInfiniteScrolling:YES];
    
    currentPage++;
    [searchedAdvertisements addObjectsFromArray:[dataManager advertisements]];
    [self.tableViewAdvertisement reloadData];
}

- (void)requestFailed:(RequestType)requestId forId:(NSString *)identifier error:(NSString *)message code:(int)code
{
    
}


@end
