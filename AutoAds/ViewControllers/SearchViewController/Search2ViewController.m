//
//  Search2ViewController.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/9/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "Search2ViewController.h"

@interface Search2ViewController ()

@end

@implementation Search2ViewController
@synthesize field;


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dataManager = [KVDataManager sharedInstance];
    }
    return self;
}


#pragma mark - ViewController's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackground.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *textLabel = [PrettyViews labelToNavigationBarWithTitle:@"Выбрать"];
    self.navigationItem.titleView = textLabel;
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:) frame:CGRectMake(0, 0, 68, 33) imageName:@"backButton.png" text:@"Назад"];
    self.navigationItem.leftBarButtonItem = bbi;
    
    switch (self.field.valueType) {
        case ValueTypeBoolean:
        {
            
            break;
        }
        case ValueTypeDictionary:
        {
            SelectValueDictionaryView *dictionaryView = [SelectValueDictionaryView loadView];
            [dictionaryView setFrame:CGRectMake(0, 0, 320, 460)];
            NSDictionary *dictionary = (NSDictionary *)self.field.value;
            dictionaryView.dictionary = dictionary;
            dictionaryView.delegate = self;
            [self.view addSubview:dictionaryView];
            
            break;
        }
        case ValueTypeString:
        case ValueTypeNumber:
        {
            SelectValueStringView *stringView = [SelectValueStringView loadView];
            stringView.valueType = self.field.valueType;
            stringView.delegate = self;
            [self.view addSubview:stringView];
            break;
        }
        case ValueTypePhoto:
        {
            
            break;
        }
        case ValueTypeDictionaryFromInternet:
        {
            SelectValueDictionaryView *dictionaryView = [SelectValueDictionaryView loadView];
            [dictionaryView setFrame:CGRectMake(0, 0, 320, 460)];
            
            NSString *fieldName = self.field.nameEnglish;
            NSDictionary *dictionary = nil;
            if ([fieldName isEqualToString:F_BRAND_ENG]) {
                dictionary = [dataManager brandsDictionary];
            }
            else if ([fieldName isEqualToString:F_MODEL_ENG]) {
                dictionary = [dataManager modelsDictionary];
            }
            else if ([fieldName isEqualToString:F_MODIFICATION_ENG]) {
                dictionary = [dataManager modificationsDictionary];
            }
            
            dictionaryView.dictionary = dictionary;
            dictionaryView.delegate = self;
            [self.view addSubview:dictionaryView];
            
            break;
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark - Actions

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - @protocol SelectValueDelegate <NSObject>

- (void)valueWasSelected:(id)selectedValue
{
    NSString *fieldName = field.nameEnglish;
    if ([fieldName isEqualToString:F_BRAND_ENG]) {
        [[NSUserDefaults standardUserDefaults] setValue:selectedValue forKey:CURRENT_BRAND];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([fieldName isEqualToString:F_MODEL_ENG]) {
        [[NSUserDefaults standardUserDefaults] setValue:selectedValue forKey:CURRENT_MODEL];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    field.selectedValue = selectedValue;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
