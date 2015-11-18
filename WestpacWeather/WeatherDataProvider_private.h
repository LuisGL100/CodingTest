//
//  WeatherDataProvider_private.h
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#ifndef WeatherDataProvider_private_h
#define WeatherDataProvider_private_h

#import <Foundation/Foundation.h>
#import "WeatherDataProvider.h"

@interface WeatherDataProvider ()

+ (NSString*)valueInInfoDictForKey:(NSString*)key;

+ (NSString*)forecastIOKey;

+ (NSString*)forecastIOHost;

+ (NSString*)forecastIOForecastPath;

+ (NSString*)urlStringForCoordinate:(WWCoordinate)coordinate service:(NSString*)service;

@end

#endif /* WeatherDataProvider_private_h */
