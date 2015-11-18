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

- (instancetype)initWithDataSource:(NSDictionary*)dataSource;

@end
