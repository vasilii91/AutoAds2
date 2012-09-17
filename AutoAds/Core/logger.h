//
//  logger.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/6/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#ifndef _LOGGER_H
#define _LOGGER_H

#ifndef DEBUG
#define LOG(...)
#else
#define LOG(...) NSLog(__VA_ARGS__)
#endif

#endif