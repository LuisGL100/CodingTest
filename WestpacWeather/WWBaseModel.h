//
//  WWBaseModel.h
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWBaseModel : NSObject

- (id)sanitizedValue:(id)value expectedClass:(Class)aClass;

@end
