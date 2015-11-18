//
//  WeatherDataProviderTests.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import "WeatherDataProvider_private.h"
#import "WeatherDataProvider.h"

#define ForecastIOKey               @"kForecastIOKey"
#define ForecastIOHost              @"kForecastIOHost"
#define ForecastIOForecastPath      @"kForecastIOForecastPath"

@interface WeatherDataProviderTests : XCTestCase

@property (nonatomic, strong) XCTestExpectation *asyncExpectation;

@end

@implementation WeatherDataProviderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    self.asyncExpectation = nil;
    
    [super tearDown];
}

- (void)testValueInInfoDict {
    
    NSString *key = [WeatherDataProvider valueInInfoDictForKey:ForecastIOKey];
    XCTAssert([key isEqualToString:@"4972e59ea28d1daefb0d2f9e522d271d"]);
    
    NSString *host = [WeatherDataProvider valueInInfoDictForKey:ForecastIOHost];
    XCTAssert([host isEqualToString:@"https://api.forecast.io"]);
    
    NSString *servicePath = [WeatherDataProvider valueInInfoDictForKey:ForecastIOForecastPath];
    XCTAssert([servicePath isEqualToString:@"forecast"]);
    
    NSString *empty = [WeatherDataProvider valueInInfoDictForKey:nil];
    XCTAssert(empty == nil);
}

- (void)testForecastIOKey {
    NSString *key = [WeatherDataProvider forecastIOKey];
    XCTAssert([key isEqualToString:@"4972e59ea28d1daefb0d2f9e522d271d"]);
}

- (void)testForecastIOHost {
    NSString *host = [WeatherDataProvider forecastIOHost];
    XCTAssert([host isEqualToString:@"https://api.forecast.io"]);
}

- (void)testForecastIOForecastPath {
    NSString *servicePath = [WeatherDataProvider forecastIOForecastPath];
    XCTAssert([servicePath isEqualToString:@"forecast"]);
}

- (void)testURLStringForCoordinate {
    WWCoordinate coordinate;
    coordinate.latitude = -33.8650;
    coordinate.longitude = -151.2094;
    NSString *urlStr = [WeatherDataProvider urlStringForCoordinate:coordinate service:@"testService"];
    XCTAssert([urlStr isEqualToString:@"https://api.forecast.io/testService/4972e59ea28d1daefb0d2f9e522d271d/-33.865000,-151.209400"]);
}

- (void)testFetchWeatherInfo {
    WWCoordinate coordinate;
    coordinate.latitude = -33.8650;
    coordinate.longitude = -151.2094;
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        NSRange range = [request.URL.path rangeOfString:@"forecast/4972e59ea28d1daefb0d2f9e522d271d/-33.865000,-151.209400"];
        return range.location != NSNotFound;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        NSString* filePath = OHPathForFile(@"forecast.json", self.class);
        return [[OHHTTPStubsResponse responseWithFileAtPath:filePath
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"application/json"}] requestTime:0.0 responseTime:0.0];
    }];
    
    self.asyncExpectation = [self expectationWithDescription:@"WeatherInfo successfully retrieved"];
    
    [WeatherDataProvider fetchWeatherInfoForCoordinate:coordinate onSuccess:^{
        [self.asyncExpectation fulfill];
    } onFailure:^(NSError *error) {
        XCTFail(@"Failed to retrieve weatherInfo");
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"Failed to retrieve weatherInfo");
        }
        else {
            XCTAssert(YES, @"WeatherInfo successfully retrieved");
        }
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        NSString *key = [WeatherDataProvider valueInInfoDictForKey:ForecastIOKey];
        XCTAssert([key isEqualToString:@"4972e59ea28d1daefb0d2f9e522d271d"]);
    }];
}

@end
