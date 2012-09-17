//
//  SearchViewController.m
//  AutoAds
//
//  Created by Kyr Dunenkoff on 8/14/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "SearchViewControllerOld.h"
#import "CellHeightProtocol.h"

#import "ButtonCell.h"
#import "RubrikCell.h"

#define CITY 0
#define TYPE 2
#define ORIGIN 4
#define MODEL 6
#define PRICE 8
#define YEAR 10;

@interface SearchViewControllerOld ()

@end

@implementation SearchViewControllerOld
{
    IBOutlet UIView *_header;
    IBOutlet UIButton *_searchButton;
    
    NSArray *_cities;
    BOOL _citiesShown;
    NSInteger _selectedCity;
    
    NSArray *_types;
    BOOL _typesShown;
    NSInteger _selectedType;
    
    NSArray *_subtypes;
    BOOL _subTypesShown;
    NSInteger _selectedSubtype;
    
    NSArray *_brands;
    BOOL _brandsShown;
    NSInteger _selectedBrand;
}

@synthesize tableView = _tableView;

#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cities = @[@"Челябинск", @"Ростов", @"Тюмень", @"Пермь", @"Самара", @"Волгоград", @"Казань", @"Архангельск", @"Ярославль"];
    _types = @[@"Легковые автомобили", @"Коммерческий транспорт", @"Мототехника", @"Водный транспорт", @"Шины и диски", @"Автозапчасти"];
    _subtypes = @[
                 @[@"Отечественные", @"Иномарки", @"Прицепы"],
                 @[@"Автобусы", @"Грузовые", @"Малый коммерческий", @"Грузовые прицепы", @"Спецтехника"],
                 @[@"Мотоциклы и мопеды", @"Квадроциклы", @"Скутеры", @"Снегоходы"],
                 @[@"Гидроциклы", @"Катера и яхты", @"Лодки"],
                 @[@"Диски", @"Шины"],
                 @[@"Ничего"],
                 ];
    
    _selectedCity = 0;
    _selectedType = 0;
    _selectedSubtype = 0;

    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundLight.png"]];
    [self.tableView setBackgroundView:iv];
    [_header setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"hugeHeader.png"]]];
    [_searchButton.titleLabel setFont:[UIFont fontWithName:FONT_DINPro_MEDIUM size:16.]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Поиск"];
    self.navigationItem.titleView = textLabel;
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.tabBarController performSegueWithIdentifier:@"flipSegue" sender:self];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section % 2 == 0)
        return 1;
    switch (section) {
        case 1:
            return _citiesShown ? [_cities count] : 0;
            break;
        case 3:
            return _typesShown ? [_types count] : 0;
            break;
        case 5:
            return _subTypesShown ? [[_subtypes objectAtIndex:_selectedType] count] : 0;
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <CellHeightProtocol> cell = (id)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section % 2 != 0) {
        RubrikCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RubrikCell"];
        switch (indexPath.section) {
            case 1:
                [cell.titleLabel setText:[_cities objectAtIndex:indexPath.row]];
                break;
            case 3:
                [cell.titleLabel setText:[_types objectAtIndex:indexPath.row]];
                break;
            case 5:
                [cell.titleLabel setText:[[_subtypes objectAtIndex:_selectedType] objectAtIndex:indexPath.row]];
                break;
        }
        return cell;
    }
    
    static NSString *CellIdentifier = @"ButtonCell";
    ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.delegate = self;
    switch (indexPath.section) {
        case 0:
            [cell.textView setText:@"Город"];
            [cell.button setTitle:[_cities objectAtIndex:_selectedCity] forState:UIControlStateNormal];
            break;
        case 2:
            [cell.textView setText:@"Тип"];
            [cell.button setTitle:[_types objectAtIndex:_selectedType] forState:UIControlStateNormal];
            break;
        case 4:
            [cell.textView setText:@"Рубрика"];
            [cell.button setTitle:[[_subtypes objectAtIndex:_selectedType] objectAtIndex:_selectedSubtype] forState:UIControlStateNormal];
            break;
    }
    return cell;
}

- (void)didTapButtonInButtonCell:(ButtonCell *)cell
{
    NSIndexPath *ip = [self.tableView indexPathForCell:cell];
    switch (ip.section) {
        case 0:
            _citiesShown = !_citiesShown;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case 2:
            _typesShown = !_typesShown;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case 4:
            _subTypesShown = !_subTypesShown;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
            _selectedCity = indexPath.row;
            _citiesShown = NO;
            [tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case 3:
            _selectedType = indexPath.row;
            _selectedSubtype = 0;
            _typesShown = NO;
            _subTypesShown = NO;
            [tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 4)] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case 5:
            _selectedSubtype = indexPath.row;
            _subTypesShown = NO;
            [tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 2)] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

@end
