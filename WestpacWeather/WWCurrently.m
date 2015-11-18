//
//  WWCurrently.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "WWCurrently.h"

#define kSummaryKey             @"summary"
#define kIconNameKey            @"icon"
#define kPrecipProbabilityKey   @"precipProbability"
#define kTemperatureKey         @"temperature"
#define kHumidityKey            @"humidity"

@interface WWCurrently ()

@property (nonatomic, readwrite) NSString *summary;
@property (nonatomic, readwrite) NSString *iconName;
@property (nonatomic, readwrite) NSNumber *precipProbability;
@property (nonatomic, readwrite) NSNumber *temperature;
@property (nonatomic, readwrite) NSNumber *humidity;

@end

@implementation WWCurrently

- (instancetype)initWithDataSource:(NSDictionary*)dataSource {
    self = [super init];
    if (self) {
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            _summary = [self sanitizedValue:dataSource[kSummaryKey] expectedClass:[NSString class]];
            _iconName = [self sanitizedValue:dataSource[kIconNameKey] expectedClass:[NSString class]];
            _precipProbability = [self sanitizedValue:dataSource[kPrecipProbabilityKey] expectedClass:[NSNumber class]];
            _temperature = [self sanitizedValue:dataSource[kTemperatureKey] expectedClass:[NSNumber class]];
            _humidity = [self sanitizedValue:dataSource[kHumidityKey] expectedClass:[NSNumber class]];
        }
    }
    return self;
}

@end
