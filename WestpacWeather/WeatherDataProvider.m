//
//  WeatherDataProvider.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "WeatherDataProvider.h"
#import <AFNetworking.h>
#import "WWForecast.h"

#define ForecastIOKey               @"kForecastIOKey"
#define ForecastIOHost              @"kForecastIOHost"
#define ForecastIOForecastPath      @"kForecastIOForecastPath"

@implementation WeatherDataProvider

+ (NSString*)valueInInfoDictForKey:(NSString*)key {
    if (!key) {
        return nil;
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSDictionary *infoDictionary = [bundle infoDictionary];
    return infoDictionary[key];
}

+ (NSString*)forecastIOKey {
    return [self valueInInfoDictForKey:ForecastIOKey];
}

+ (NSString*)forecastIOHost {
    return [self valueInInfoDictForKey:ForecastIOHost];
}

+ (NSString*)forecastIOForecastPath {
    return [self valueInInfoDictForKey:ForecastIOForecastPath];
}

+ (NSString*)urlStringForCoordinate:(WWCoordinate)coordinate service:(NSString*)service {
    NSString *apiHost = [self forecastIOHost];
    NSString *apiKey = [self forecastIOKey];
    if (!apiKey || !apiHost || !service) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@/%@/%@/%.6f,%.6f", apiHost ,service, apiKey, coordinate.latitude, coordinate.longitude];
}

+ (void)fetchWeatherInfoForCoordinate:(WWCoordinate)coordinate
                            onSuccess:(void(^)(WWForecast *forecast))successBlock
                            onFailure:(void(^)(NSError *error))failureBlock {
    
    NSString *urlStr = [self urlStringForCoordinate:coordinate service:[self forecastIOForecastPath]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             
             WWForecast *forecast = [[WWForecast alloc] initWithDataSource:responseObject];
         
             if (successBlock) {
                 successBlock(forecast);
             }
         }
         failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             if (failureBlock) {
                 failureBlock(error);
             }
         }
     ];
}
@end
