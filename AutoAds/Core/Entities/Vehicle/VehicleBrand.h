//
//  VehicleBrand.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/11/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "VehicleModel.h"

@interface VehicleBrand : Jastor

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSDictionary *subrubrics;
@property (nonatomic, retain) NSString *order;

@property (nonatomic, retain) NSMutableArray *vehicleModels;

@end
