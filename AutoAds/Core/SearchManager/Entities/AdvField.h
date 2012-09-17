//
//  AdField.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/7/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvEnums.h"

enum
{
    ValueTypeString,
    ValueTypeNumber,
    ValueTypeBoolean,
    ValueTypeDictionary,
    ValueTypePhoto,
    ValueTypeDictionaryFromInternet,
    ValueTypeCheckboxDictionaryFromInternet
};
typedef NSUInteger ValueType;

@interface AdvField : NSObject

@property (nonatomic, retain) NSString *nameEnglish;    // name of the field
@property (nonatomic, retain) NSString *nameRussian;    // name of the field in Russian
@property (nonatomic, retain) id value;                 // value of the field
@property (nonatomic, retain) id valueByDefault;        // value by default of the field
@property (nonatomic, retain) id selectedValue;         // selected value of the field
@property (nonatomic, assign) ValueType valueType;      // type of value of the field
@property (nonatomic, assign) BOOL isShownOnForm;       // is need to show on form
@property (nonatomic, assign) BOOL isPrecondition;      // is should be fill
@property (nonatomic, assign) BOOL isShortSearch;
@property (nonatomic, assign) BOOL isExtendedSearch;
@property (nonatomic, assign) BOOL isTableOutput;
@property (nonatomic, assign) BOOL isFullOutput;
@property (nonatomic, retain) AdvField *dependentField;
@property (nonatomic, assign) BOOL isExistMainField;

+ (AdvField *)newAdvField:(NSString *)nameE :(NSString *)nameR :(id)val :(id)valByDef :(id)selectedVal :(ValueType)valType :(BOOL)isShown :(BOOL)isPrecond :(BOOL)isShort :(BOOL)isExtended :(BOOL)isTable :(BOOL)isFull;

- (void)setMainValues:(NSString *)nameE :(NSString *)nameR :(id)val :(id)valByDef :(id)selectedVal :(ValueType)valType;
- (void)setBoolValues:(BOOL)isShown :(BOOL)isPrecond :(BOOL)isShort :(BOOL)isExtended :(BOOL)isTable :(BOOL)isFull;

@end
