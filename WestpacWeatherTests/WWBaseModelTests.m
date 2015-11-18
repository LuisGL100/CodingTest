//
//  WWBaseModelTests.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WWBaseModel.h"

@interface WWBaseModelTests : XCTestCase

@end

@implementation WWBaseModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNilifyIfCorrupted {
    WWBaseModel *baseModel = [[WWBaseModel alloc] init];
    NSString *myString = [baseModel sanitizedValue:@"Hello world" expectedClass:[NSString class]];
    XCTAssert([myString isEqualToString:@"Hello world"]);
    
    NSNumber *myNumber = [baseModel sanitizedValue:@10 expectedClass:[NSString class]];
    XCTAssert(myNumber == nil);
    
    NSNumber *myOtherNumber = [baseModel sanitizedValue:@5 expectedClass:nil];
    XCTAssert(myOtherNumber == nil);
    
    NSString *myOtherString = [baseModel sanitizedValue:[NSNull null] expectedClass:[NSNull class]];
    XCTAssert(myOtherString == nil);
}

@end
