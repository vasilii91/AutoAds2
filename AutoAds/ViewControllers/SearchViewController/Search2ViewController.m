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
@synthesize typeOfSearch2ViewController;


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
    UIBarButtonItem *bbi = [PrettyViews backBarButtonWithTarget:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = bbi;
    
    UIBarButtonItem *bbi2 = [PrettyViews backBarButtonWithTarget:self action:@selector(cleanCurrentValue) frame:CGRectMake(0, 0, 39, 39) imageName:@"clean_button.png" imageNameSelected:@"clean_button_selected.png" text:nil];
    self.navigationItem.rightBarButtonItem = bbi2;
    
    switch (self.field.valueType) {
        case ValueTypePhone:
        {
            SelectValuePhoneView *phoneView = [SelectValuePhoneView loadView];
            phoneView.labelHeader.text = self.field.nameRussian;
            phoneView.frame = CGRectMake(0, 0, 320, 460);
            [self.view addSubview:phoneView];
            break;
        }
        case ValueTypeCheckboxDictionaryFromInternet:
        {
            SelectValueOptionsView *optionsView = [SelectValueOptionsView loadView];
            optionsView.labelHeader.text = self.field.nameRussian;
            optionsView.frame = CGRectMake(0, 0, 320, 460);
            optionsView.delegate = self;
            optionsView.options = [[KVDataManager sharedInstance] options];
            [self.view addSubview:optionsView];
            break;
        }
        case ValueTypeCaptcha:
        {
            SelectValueCaptchaView *captchaView = [SelectValueCaptchaView loadView];
            captchaView.labelHeader.text = self.field.nameRussian;
            captchaView.delegate = self;
            [self.view addSubview:captchaView];
            break;
        }
        case ValueTypeDictionary:
        {
            SelectValueDictionaryView *dictionaryView = [SelectValueDictionaryView loadView];
            dictionaryView.labelHeader.text = self.field.nameRussian;
            [dictionaryView setFrame:CGRectMake(0, 0, 320, 460)];
            NSDictionary *dictionary = (NSDictionary *)self.field.value;
            dictionaryView.dictionary = dictionary;
            dictionaryView.delegate = self;
            if (typeOfSearch2ViewController == Search2ViewControllerTypeSearch) {
                if ([self.field.nameEnglish isEqualToString:F_FUEL_ENG]) {
                    dictionaryView.selectValueDictionaryType = SelectValueDictionaryFuel;
                }
                else if ([self.field.nameEnglish isEqualToString:F_STATES_ENG]) {
                    dictionaryView.selectValueDictionaryType = SelectValueDictionaryStates;
                }
                else {
                    dictionaryView.selectValueDictionaryType = SelectValueDictionaryUnknown;
                }
            }
            else {
                dictionaryView.selectValueDictionaryType = SelectValueDictionaryUnknown;
            }
            
            [self.view addSubview:dictionaryView];
            
            break;
        }
        case ValueTypeString:
        case ValueTypeNumber:
        case ValueTypeEmail:
        {
            SelectValueStringView *stringView = [SelectValueStringView loadView];
            stringView.labelHeader.text = self.field.nameRussian;
            stringView.valueType = self.field.valueType;
            stringView.delegate = self;
            stringView.selectedValue = self.field.selectedValue;
            [self.view addSubview:stringView];
            break;
        }
        case ValueTypeDictionaryFromInternet:
        {
            SelectValueDictionaryView *dictionaryView = [SelectValueDictionaryView loadView];
            dictionaryView.labelHeader.text = self.field.nameRussian;
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
            field.value = dictionary;
            
            dictionaryView.dictionary = dictionary;
            dictionaryView.delegate = self;
            
            if (typeOfSearch2ViewController == Search2ViewControllerTypeSearch) {
                if ([self.field.nameEnglish isEqualToString:F_MODEL_ENG]) {
                    dictionaryView.selectValueDictionaryType = SelectValueDictionaryModels;
                }
                else {
                    dictionaryView.selectValueDictionaryType = SelectValueDictionaryUnknown;
                }
            }
            else {
                dictionaryView.selectValueDictionaryType = SelectValueDictionaryUnknown;
            }
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

- (void)cleanCurrentValue
{
    [dataManager cleanSelectedDataSourceByFieldName:field.nameEnglish];
    field.selectedValue = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - @protocol SelectValueDelegate <NSObject>

- (void)valueWasSelected:(id)selectedValue
{
    NSString *fieldName = field.nameEnglish;
    NSString *currentKey = nil;
    
    if ([fieldName isEqualToString:F_BRAND_ENG]) {
        currentKey = CURRENT_BRAND;
    }
    else if ([fieldName isEqualToString:F_MODEL_ENG]) {
        currentKey = CURRENT_MODEL;
    }
    else if ([fieldName isEqualToString:F_RUBRIC_ENG]) {
        currentKey = CURRENT_RUBRIC;
    }
    else if ([fieldName isEqualToString:F_SUBRUBRIC_ENG]) {
        currentKey = CURRENT_SUBRUBRIC;
    }
    
    if (currentKey != nil) {
        [[NSUserDefaults standardUserDefaults] setValue:selectedValue forKey:currentKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    field.selectedValue = selectedValue;
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
