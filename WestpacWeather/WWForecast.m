//
//  WWForecast.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "WWForecast.h"
#import "WWCurrently.h"

#define kLatitudeKey        @"latitude"
#define kLongitudeKey       @"longitude"
#define kTimezoneKey        @"timezone"
#define kOffsetKey          @"offset"
#define kCurrentlyKey       @"currently"

@interface WWForecast ()

@property (nonatomic, readwrite) NSNumber *latitude;
@property (nonatomic, readwrite) NSNumber *longitude;
@property (nonatomic, readwrite) NSString *timezone;
@property (nonatomic, readwrite) NSNumber *offset;
@property (nonatomic, readwrite) WWCurrently *currently;
@property (nonatomic, readwrite) NSError *error;

@end


@implementation WWForecast

- (instancetype)initWithDataSource:(NSDictionary*)dataSource {
    self = [super init];
    if (self) {
        
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            _latitude = [self sanitizedValue:dataSource[kLatitudeKey] expectedClass:[NSNumber class]];
            _longitude = [self sanitizedValue:dataSource[kLongitudeKey] expectedClass:[NSNumber class]];
            _timezone = [self sanitizedValue:dataSource[kTimezoneKey] expectedClass:[NSString class]];
            _offset = [self sanitizedValue:dataSource[kOffsetKey] expectedClass:[NSNumber class]];
            NSDictionary *currentlyDict = [self sanitizedValue:dataSource[kCurrentlyKey] expectedClass:[NSDictionary class]];
            _currently = [[WWCurrently alloc] initWithDataSource:currentlyDict];
        }
    }
    return self;
}

@end
