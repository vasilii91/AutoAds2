//
//  KVDataManagerProtocol.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/22/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KVDataManagerDelegate <NSObject>

- (void)dataWasSuccessfullyParsed;
- (void)errorWasOccuredWithError:(NSString *)textError;

@end
