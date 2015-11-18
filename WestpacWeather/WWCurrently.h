//
//  WWCurrently.h
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWBaseModel.h"

@interface WWCurrently : WWBaseModel

@property (nonatomic, readonly) NSString *summary;
@property (nonatomic, readonly) NSString *iconName;
@property (nonatomic, readonly) NSNumber *precipProbability;
@property (nonatomic, readonly) NSNumber *temperature;
@property (nonatomic, readonly) NSNumber *humidity;

// Ignoring all other information (e.g. windSpeed, visibility, etc) for the sake of simplicity


- (instancetype)initWithDataSource:(NSDictionary*)dataSource;

@end
