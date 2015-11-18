//
//  WWCurrentlyTests.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WWCurrently.h"

@interface WWCurrentlyTests : XCTestCase

@end

@implementation WWCurrentlyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCurrentlyModelWithCorrectInfo {
    
    NSDictionary *dataSource = @{
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
                                 };
    
    WWCurrently *currently = [[WWCurrently alloc] initWithDataSource:dataSource];
    XCTAssert([currently.summary isEqualToString:@"Partly Cloudy"]);
    XCTAssert([currently.iconName isEqualToString:@"partly-cloudy-night"]);
    XCTAssert([currently.precipProbability isEqualToNumber:@0]);
    XCTAssert([currently.temperature isEqualToNumber:@56.15]);
    XCTAssert([currently.humidity isEqualToNumber:@0.79]);
}

- (void)testCurrentlyModelWithNilInfo {
    
    WWCurrently *currently = [[WWCurrently alloc] initWithDataSource:nil];
    XCTAssert(currently.summary == nil);
    XCTAssert(currently.iconName == nil);
    XCTAssert(currently.precipProbability == nil);
    XCTAssert(currently.temperature == nil);
    XCTAssert(currently.humidity == nil);
}

- (void)testCurrentlyModelWithNullData {
    
    NSDictionary *dataSource = @{
                                 @"time": @1447823453,
                                 @"summary": @"Partly Cloudy",
                                 @"icon": [NSNull null],
                                 @"nearestStormDistance": @125,
                                 @"nearestStormBearing": @348,
                                 @"precipIntensity": @0,
                                 @"precipProbability": @0,
                                 @"temperature": [NSNull null],
                                 @"apparentTemperature": @56.15,
                                 @"dewPoint": @49.8,
                                 @"humidity": @0.79,
                                 @"windSpeed": @5.11,
                                 @"windBearing": @315,
                                 @"visibility": @7.23,
                                 @"cloudCover": @0.41,
                                 @"pressure": @1024.83,
                                 @"ozone": @268.81
                                 };
    
    WWCurrently *currently = [[WWCurrently alloc] initWithDataSource:dataSource];
    XCTAssert([currently.summary isEqualToString:@"Partly Cloudy"]);
    XCTAssert(currently.iconName == nil);
    XCTAssert([currently.precipProbability isEqualToNumber:@0]);
    XCTAssert(currently.temperature == nil);
    XCTAssert([currently.humidity isEqualToNumber:@0.79]);
}

- (void)testCurrentlyModelWithWrongDataSource {
    
    NSArray *dataSource = @[@"Hello", @"World"];
    WWCurrently *currently = [[WWCurrently alloc] initWithDataSource:(NSDictionary*)dataSource];
    XCTAssert(currently.summary == nil);
    XCTAssert(currently.iconName == nil);
    XCTAssert(currently.precipProbability == nil);
    XCTAssert(currently.temperature == nil);
    XCTAssert(currently.humidity == nil);
}

@end
