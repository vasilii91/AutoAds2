//
//  PGSlider.m
//  PGControll
//
//  Created by Eugene on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PGSlider.h"

@implementation PGSlider

@synthesize bottomCap, topCap, percentValue;
@synthesize associatedValue, associatedValues;

@synthesize maxValue, minValue, value;
@synthesize step, stepping;
@synthesize currentSelectedIndex;

@synthesize acceptedValues;
@synthesize style;

-(void) setPercentValue:(float)percentValueParam
{
    [self setPersentValue:percentValueParam animated:NO];
}

-(void) setStyle:(PGSliderStyle)styleParam
{
    style = styleParam;
    if (style == PGSliderStyleBlue)
        self.imagePattern = [UIImage imageNamed:@"pattern_tube_blue"];
    if (style == PGSliderStyleDarkBlue)
        self.imagePattern = [UIImage imageNamed:@"pattern_tube_dark_blue"];
    if (style == PGSliderStyleGray)
        self.imagePattern = [UIImage imageNamed:@"pattern_tube_gray_top"];
    if (style == PGSliderStyleLightBlue)
        self.imagePattern = [UIImage imageNamed:@"pattern_tube_light_blue"];
    
}

-(void) setValueFromPercValue
{
    value = (maxValue - minValue) * percentValue + minValue;
}

-(void) setPersValueFromValue
{
    percentValue = (value - minValue) / (maxValue - minValue);
}

-(void) checkValueForStepping
{
    value = round((value - minValue) / step) * step + minValue;
}

-(void) setImagePattern:(UIImage *)imagePatternParam
{
    _contentView.image = imagePatternParam;
}

-(UIImage*) imagePattern
{
    return _contentView.image;
}

-(void) checkForAcceptedValues
{
    if ([acceptedValues count] > 0)
    {
        int index = 0;
        float minDifference = fabsf(value - [(NSNumber*)[acceptedValues objectAtIndex:0] floatValue]);
        for (int i = 1; i < [acceptedValues count]; i++)
        {
            float nv = fabsf(value - [(NSNumber*)[acceptedValues objectAtIndex:i] floatValue]);
            if (nv < minDifference)
            {
                index = i;
                minDifference = nv;
            }
        }
        currentSelectedIndex = index;
        value = [(NSNumber*)[acceptedValues objectAtIndex:index] floatValue];
    }
}

-(void) setupValues
{
    [self setValueFromPercValue];
    
    if (stepping)
    {
        [self checkValueForStepping];
        [self setPersValueFromValue];
    }
    else
        if (acceptedValues != nil)
        {
            [self checkForAcceptedValues];
            [self setPersValueFromValue];
        }
    [self setPersentValue:percentValue animated:YES];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void) setPersentValue:(float)persentValueParam animated:(BOOL) animated
{
    if (animated)
    {
        [UIView beginAnimations:@"animate slider" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.4];
        //block animation corrupt  
    }
    
    percentValue = persentValueParam;

    _contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height* percentValue);     
    [self setValueFromPercValue];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    if (animated)
    {
        [UIView commitAnimations];
    }
}

-(void) contentFrameInit
{
    _contentView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
    _backView.frame = self.bounds;
    self.transform = CGAffineTransformMakeScale(1, -1);
}

-(void) makeInit
{
    _contentView = [[UIImageView alloc] init];
    _backView = [[UIImageView alloc] init];
    _backView.image = [UIImage imageNamed:@"pattern_tube_gray_top"];

    

    [self addSubview:_backView];
    [self addSubview:_contentView];
    self.percentValue = 0;
}

-(id) init
{
    self = [super init];
    if (self) 
    {
        [self makeInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self makeInit];
        [self contentFrameInit];
    }
    return self;
}
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) 
    {
        [self makeInit];
        [self contentFrameInit];
    }
    return self;
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    self.percentValue = MIN(MAX(touchLocation.y / self.frame.size.height, 0.0) , 1);
    [self beginTrackingWithTouch:touch withEvent:event];
    
    [self sendActionsForControlEvents:UIControlEventEditingDidBegin];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    self.percentValue = MIN(MAX(touchLocation.y / self.frame.size.height, 0.0) , 1);
    [self continueTrackingWithTouch:touch withEvent:event];
    
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    [self endTrackingWithTouch:touch withEvent:event];
    
    [self setupValues];
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];    
}

-(id) associatedValue
{
    NSNumber* key = [NSNumber numberWithInt:round(self.value)];
    return [associatedValues objectForKey:key];
}
-(float) valueForAssociatedValue:(NSString*) valParam
{
    for (NSNumber* value_ in [self.associatedValues allKeys])
    {
        if ([valParam isEqualToString:[self.associatedValues objectForKey:value_]])
            return [value_ floatValue];
    }
    return 0;
}
@end
