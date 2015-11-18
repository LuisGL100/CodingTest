//
//  WWForecastTests.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WWForecast.h"
#import "WWCurrently.h"

@interface WWForecastTests : XCTestCase

@end

@implementation WWForecastTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testForecastModelWithCorrectInfo {
    
    NSDictionary *dataSource = @{@"latitude": @37.8267,
                                 @"longitude": @-122.423,
                                 @"timezone": @"America/Los_Angeles",
                                 @"offset": @-8,
                                 @"currently": @{
                                     @"time": @1447823453,
                                     @"summary": @"Partly Cloudy",
                                     @"icon": @"partly-cloudy-night",
                                     @"nearestStormDistance": @125,
                                     @"nearestStormBearing": @348,
                                     @"precipIntensity": @0,
                                     @"precipProbability": @0,
                                     @"temperature": @56.15,
                                     @"apparentTemperature": @56.15,
                                     @"dewPoint": @49.8,
                                     @"humidity": @0.79,
                                     @"windSpeed": @5.11,
                                     @"windBearing": @315,
                                     @"visibility": @7.23,
                                     @"cloudCover": @0.41,
                                     @"pressure": @1024.83,
                                     @"ozone": @268.81
                                 }};
    
    WWForecast *forecast = [[WWForecast alloc] initWithDataSource:dataSource];
    XCTAssert([forecast.latitude isEqualToNumber:@37.8267]);
    XCTAssert([forecast.longitude isEqualToNumber:@-122.423]);
    XCTAssert([forecast.timezone isEqualToString:@"America/Los_Angeles"]);
    XCTAssert([forecast.offset isEqualToNumber:@-8]);
    XCTAssert([forecast.currently isKindOfClass:[WWCurrently class]]);
}

- (void)testForecastModelWithNilInfo {
    
    WWForecast *forecast = [[WWForecast alloc] initWithDataSource:nil];
    XCTAssert(forecast.latitude == nil);
    XCTAssert(forecast.longitude == nil);
    XCTAssert(forecast.timezone == nil);
    XCTAssert(forecast.offset == nil);
    XCTAssert(forecast.currently == nil);
}

- (void)testForecastModelWithNullData {
    
    NSDictionary *dataSource = @{@"latitude": [NSNull null],
                                 @"longitude": @-122.423,
                                 @"timezone": [NSNull null],
                                 @"offset": @-8};
    
    WWForecast *forecast = [[WWForecast alloc] initWithDataSource:dataSource];
    XCTAssert(forecast.latitude == nil);
    XCTAssert([forecast.longitude isEqualToNumber:@-122.423]);
    XCTAssert(forecast.timezone == nil);
    XCTAssert([forecast.offset isEqualToNumber:@-8]);
}

- (void)testForecastModelWithWrongDataSource {
    
    NSArray *dataSource = @[@"Hello", @"World"];
    WWForecast *forecast = [[WWForecast alloc] initWithDataSource:(NSDictionary*)dataSource];
    XCTAssert(forecast.latitude == nil);
    XCTAssert(forecast.longitude == nil);
    XCTAssert(forecast.timezone == nil);
    XCTAssert(forecast.offset == nil);
    XCTAssert(forecast.currently == nil);
}

@end
