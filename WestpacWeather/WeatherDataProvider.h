//
//  WeatherDataProvider.h
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    double latitude;
    double longitude;
} WWCoordinate;

@interface WeatherDataProvider : NSObject

+ (void)fetchWeatherInfoForCoordinate:(WWCoordinate)coordinate
                            onSuccess:(void(^)(void))successBlock
                            onFailure:(void(^)(NSError *error))failureBlock;

@end
