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
@property (nonatomic, readwrite) IconType iconType;
@property (nonatomic, readwrite) NSNumber *precipProbability;
@property (nonatomic, readwrite) NSNumber *temperature;
@property (nonatomic, readwrite) NSNumber *humidity;
@property (nonatomic, strong) NSDictionary *iconNamesAndTypes;

@end

@implementation WWCurrently

- (instancetype)init {
    return [self initWithDataSource:nil];
}

- (instancetype)initWithDataSource:(NSDictionary*)dataSource {
    self = [super init];
    if (self) {
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            _summary = [self sanitizedValue:dataSource[kSummaryKey] expectedClass:[NSString class]];
            _precipProbability = [self sanitizedValue:dataSource[kPrecipProbabilityKey] expectedClass:[NSNumber class]];
            _temperature = [self sanitizedValue:dataSource[kTemperatureKey] expectedClass:[NSNumber class]];
            _humidity = [self sanitizedValue:dataSource[kHumidityKey] expectedClass:[NSNumber class]];
            
            NSString *iconName = [self sanitizedValue:dataSource[kIconNameKey] expectedClass:[NSString class]];
            _iconType = [self iconTypeForName:iconName];
        }
    }
    return self;
}

- (void)mapIconNamesToTypes {
    if (!self.iconNamesAndTypes) {
        self.iconNamesAndTypes = @{@"clear-day": [NSNumber numberWithInteger:IconTypeClearDay],
                                   @"clear-night": [NSNumber numberWithInteger:IconTypeClearNight],
                                   @"cloudy": [NSNumber numberWithInteger:IconTypeCloudy],
                                   @"fog": [NSNumber numberWithInteger:IconTypeFog],
                                   @"partly-cloudy-day": [NSNumber numberWithInteger:IconTypePartlyCloudyDay],
                                   @"partly-cloudy-night": [NSNumber numberWithInteger:IconTypePartlyCloudyNight],
                                   @"rain": [NSNumber numberWithInteger:IconTypeRain],
                                   @"sleet": [NSNumber numberWithInteger:IconTypeSleet],
                                   @"snow": [NSNumber numberWithInteger:IconTypeSnow],
                                   @"wind": [NSNumber numberWithInteger:IconTypeWind]};
    }
}

- (IconType)iconTypeForName:(NSString*)iconName {
    [self mapIconNamesToTypes];
    NSNumber *iconTypeNumber = [self.iconNamesAndTypes valueForKey:iconName];
    if (!iconTypeNumber) {
        return IconTypeUnknown;
    }
    return iconTypeNumber.integerValue;
}

@end
