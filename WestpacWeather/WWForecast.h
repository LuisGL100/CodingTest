//
//  WWForecast.h
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWBaseModel.h"

@class WWCurrently;

@interface WWForecast : WWBaseModel

@property (nonatomic, readonly) NSNumber *latitude;
@property (nonatomic, readonly) NSNumber *longitude;
@property (nonatomic, readonly) NSString *timezone;
@property (nonatomic, readonly) NSNumber *offset;
@property (nonatomic, readonly) WWCurrently *currently;

// Ignoring all other information (e.g. hourly, minutely, daily, etc) for the sake of simplicity

- (instancetype)initWithDataSource:(NSDictionary*)dataSource;

@end
