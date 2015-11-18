//
//  WWBaseModel.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "WWBaseModel.h"

@implementation WWBaseModel

- (id)sanitizedValue:(id)value expectedClass:(Class)aClass {
    if ([value isKindOfClass:[NSNull class]] || aClass == nil || ![value isKindOfClass:aClass]) {
        return nil;
    }
    return value;
}

@end
