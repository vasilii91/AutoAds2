//
//  Constants.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IPAD_HEIGHT 1024
#define IPAD_WIDTH 768
#define IPAD_TAB_BAR_HEIGHT 84
#define IPAD_NAV_BAR_HEIGHT 44
#define IPAD_KEYBOARD_PORTRAIT_HEIGHT 264
#define IPAD_KEYBOARD_LANDSCAPE_HEIGHT 352

#define IPHONE_HEIGHT 480
#define IPHONE_WIDTH 320
#define IPHONE_TAB_BAR_HEIGHT 51
#define IPHONE_NAV_BAR_HEIGHT 41
#define IPHONE_KEYBOARD_PORTRAIT_HEIGHT 216
#define IPHONE_KEYBOARD_LANDSCAPE_HEIGHT 162

#define IDEVICE_HEIGHT (IS_IPHONE ? IPHONE_HEIGHT : IPAD_HEIGHT)
#define IDEVICE_WIDTH (IS_IPHONE ? IPHONE_WIDTH : IPAD_WIDTH)
#define IDEVICE_TAB_BAR_HEIGHT (IS_IPHONE ? IPHONE_TAB_BAR_HEIGHT : IPAD_TAB_BAR_HEIGHT)
#define IDEVICE_NAV_BAR_HEIGHT (IS_IPHONE ? IPHONE_NAV_BAR_HEIGHT : IPAD_NAV_BAR_HEIGHT)
#define IDEVICE_KEYBOARD_PORTRAIT_HEIGHT (IS_IPHONE ? IPHONE_KEYBOARD_PORTRAIT_HEIGHT : IPAD_KEYBOARD_PORTRAIT_HEIGHT)
#define IDEVICE_KEYBOARD_LANDSCAPE_HEIGHT (IS_IPHONE ? IPHONE_KEYBOARD_LANDSCAPE_HEIGHT : IPAD_KEYBOARD_LANDSCAPE_HEIGHT)
#define IDEVICE_STATUS_BAR_HEIGHT 20

#define FONT_DINPro_MEDIUM @"DINPro-Medium"
#define FONT_DINPro_REGULAR @"DINPro-Regular"
#define FONT_DINPro_BOLD @"DINPro-Bold"

#define FONT_COLOR_MY_BLUE_COLOR [UIColor colorWithRed:41.0/255.0 green:95.0/255.0 blue:171.0/255.0 alpha:1]

#define DOCUMENTS_DIRECTORY [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

#define DEFAULT_PHOTOS_DIRECTORY_NAME @"photos"

#define PATH_TO_CAPTCHA_IMAGE [NSString stringWithFormat:@"%@/%@.%@", DOCUMENTS_DIRECTORY, CAPTCHA_NAME, PHOTOS_EXTENSION]
#define PHOTOS_DIRECTORY [NSString stringWithFormat:@"%@/%@", DOCUMENTS_DIRECTORY, DEFAULT_PHOTOS_DIRECTORY_NAME]
#define COUNT_OF_PHOTOS_IN_CAR_PHOTOS @"count of photos in car photos"
#define PHOTOS_EXTENSION @"png"
#define CAPTCHA_NAME @"captcha"

#define SELECTED_TAB_BAR_INDEX @"selected tab bar index"
#define CURRENT_BRAND @"current brand"
#define CURRENT_MODEL @"current model"
#define CURRENT_RUBRIC @"current rubric"
#define CURRENT_SUBRUBRIC @"current subrubric"
#define CURRENT_NAME_OF_GROUP_OF_CITIES @"current number of group of cities"

#define STANDART_ATTENTION_TEXT_FOR_TEXT_FIELD @"Пожалуйста, заполните это поле"
#define STANDART_ATTENTION_TEXT_FOR_DICTIONARY @"Пожалуйста, выберите значение"
#define STANDART_ATTENTION_TEXT_FOR_EMAIL @"Пожалуйста, укажите Ваш электронный ящик"