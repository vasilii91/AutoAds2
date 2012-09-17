//
//  AdField.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/7/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "AdvField.h"

@implementation AdvField

+ (AdvField *)newAdvField:(NSString *)nameE :(NSString *)nameR :(id)val :(id)valByDef :(id)selectedVal :(ValueType)valType :(BOOL)isShown :(BOOL)isPrecond :(BOOL)isShort :(BOOL)isExtended :(BOOL)isTable :(BOOL)isFull
{
    AdvField *field = [AdvField new];
    field.nameEnglish = nameE;
    field.nameRussian = nameR;
    field.value = val;
    field.valueByDefault = valByDef;
    field.selectedValue = selectedVal;
    field.valueType = valType;
    field.isShownOnForm = isShown;
    field.isPrecondition = isPrecond;
    field.isShortSearch = isShort;
    field.isExtendedSearch = isExtended;
    field.isTableOutput = isTable;
    field.isFullOutput = isFull;
    
    return field;
}

- (void)setMainValues:(NSString *)nameE :(NSString *)nameR :(id)val :(id)valByDef :(id)selectedVal :(ValueType)valType
{
    self.nameEnglish = nameE;
    self.nameRussian = nameR;
    self.value = val;
    self.valueByDefault = valByDef;
    self.selectedValue = selectedVal;
    self.valueType = valType;
}

- (void)setBoolValues:(BOOL)isShown :(BOOL)isPrecond :(BOOL)isShort :(BOOL)isExtended :(BOOL)isTable :(BOOL)isFull
{
    self.isShownOnForm = isShown;
    self.isPrecondition = isPrecond;
    self.isShortSearch = isShort;
    self.isExtendedSearch = isExtended;
    self.isTableOutput = isTable;
    self.isFullOutput = isFull;
}

- (id)value
{
    if (_dependentField != nil) {
        if (_isExistMainField == NO) {
            id newValue = [_value valueForKey:_dependentField.selectedValue];
            return newValue;
        }
        else {
            _dependentField.selectedValue = nil;
        }
    }
    return _value;
}

@end
