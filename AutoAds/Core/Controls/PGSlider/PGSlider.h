//
//  PGSlider.h
//  PGControll
//
//  Created by Eugene on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
enum {
    PGSliderStyleBlue       = 0,                       
    PGSliderStyleDarkBlue      = 1,   
    PGSliderStyleGray          = 2,
    PGSliderStyleLightBlue     = 3
};
typedef NSUInteger PGSliderStyle;
@interface PGSlider : UIControl
{
    UIImageView* _contentView;
    UIImageView* _backView;
}
@property (nonatomic, assign) PGSliderStyle style;
@property (nonatomic, assign) float percentValue;
@property (nonatomic, assign) float bottomCap;

@property (nonatomic, assign) float maxValue;
@property (nonatomic, assign) float minValue;
@property (nonatomic, readonly) float value;
@property (nonatomic, assign) float step;
@property (nonatomic, assign) BOOL stepping; //:)

@property (nonatomic, strong) NSArray* acceptedValues;
@property (nonatomic, readonly) int currentSelectedIndex;

@property (nonatomic, assign) float topCap;
@property (nonatomic, strong) UIImage* imagePattern;
@property (nonatomic, strong) NSMutableDictionary* associatedValues;
@property (nonatomic, readonly) id associatedValue;

-(void) setPersentValue:(float)persentValueParam animated:(BOOL) animated;
-(float) valueForAssociatedValue:(NSString*) valParam;
@end
