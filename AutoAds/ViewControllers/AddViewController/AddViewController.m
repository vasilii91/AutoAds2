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
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(cleanQuery) frame:CGRectMake(0, 0, 39, 39) imageName:@"addBarIcon.png" text:nil];
    self.navigationItem.rightBarButtonItem = bbi2;
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    self.webView.delegate = self;
    
    NSString *html = [NSString stringWithFormat:@"<html><body><p align=\"center\"><font size=\"2\" face=\"%@\">Нажимая кнопку \"Добавить\" я подтверждаю свое согласие с <a href=\"http://www.autochel.ru/help/car/rules\">правилами размещения объявлений</a></font></p></body></html>", FONT_DINPro_REGULAR];
    [self.webView loadHTMLString:html baseURL:nil];
    
    f0 = (AdvField *)[fields objectAtIndex:0];
    f1 = (AdvField *)[fields objectAtIndex:1];
    f2 = (AdvField *)[fields objectAtIndex:2];
    f0.selectedValue = [[[AdvDictionaries Cities] allKeys] objectAtIndex:0];
    f1.selectedValue = [[[AdvDictionaries Rubrics] allKeys] objectAtIndex:0];
    f2.selectedValue = [[[AdvDictionaries SubrubricsMotors] allKeys] objectAtIndex:1];
}

- (void)viewDidUnload
{
    [self setTableViewFields:nil];
    [self setScrollView:nil];
    [self setWebView:nil];
    [self setButtonAdd:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (([f1.nameEnglish isEqualToString:F_RUBRIC_ENG] &&
         [f2.nameEnglish isEqualToString:F_SUBRUBRIC_ENG] &&
         f1.selectedValue != nil &&
         f2.selectedValue != nil) ||
        [f1.selectedValue isEqualToString:@"Автозапчасти"]) {
        
        currentGroup = [searchManager categoryAddAdvertisementByRubric:f1.selectedValue subrubric:f2.selectedValue];
        fields = [currentGroup getObligatoryFields];
    }
    
    self.tableViewFields.backgroundColor = [UIColor clearColor];
    CGRect tableFrame = self.tableViewFields.frame;
    CGFloat tableHeight = [fields count] * TABLE_CELL_HEIGHT;
    tableFrame.size.height = tableHeight;
    self.tableViewFields.frame = tableFrame;
    
    self.scrollView.contentSize = CGSizeMake(320,
                                             BUTTON_HEIGHT + WEB_VIEW_HEIGHT + tableHeight);
    
    CGRect buttonFrame = self.buttonAdd.frame;
    buttonFrame.origin.y = tableHeight + WEB_VIEW_HEIGHT;
    self.buttonAdd.frame = buttonFrame;
    
    CGRect webViewFrame = self.webView.frame;
    webViewFrame.origin.y = tableHeight;
    self.webView.frame = webViewFrame;
    
    [self.tableViewFields reloadData];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.tabBarController performSegueWithIdentifier:@"flipSegue" sender:self];
}

- (void)cleanQuery
{
    for (AdvField *field in fields) {
        field.selectedValue = nil;
    }
    fields = [[searchManager findGroupByGroupType:GroupTypeMain] getObligatoryFields];
    
    [self.tableViewFields reloadData];
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
    
    AdvField *field = [fields objectAtIndex:indexPath.row];
    NSString *title = field.nameRussian;
    NSString *value = field.selectedValue == nil ? field.valueByDefault : field.selectedValue;
    
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
    
    Search2ViewController *search2VC = [Search2ViewController new];
    search2VC.field = lastSelectedField;
    [self.navigationController pushViewController:search2VC animated:YES];
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
@end
