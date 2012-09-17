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
        // Custom initialization
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
    field.selectedValue = selectedValue;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
