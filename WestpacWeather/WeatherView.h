//
//  WeatherView.h
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWForecast;

@interface WeatherView : UIView

@property (nonatomic, readonly) UIImageView *weatherImageView;
@property (nonatomic, readonly) UILabel *summaryLabel;
@property (nonatomic, readonly) UILabel *precipProbability;
@property (nonatomic, readonly) UILabel *temperature;
@property (nonatomic, readonly) UILabel *humidity;
@property (nonatomic, readonly) UIButton *retryBtn;

- (void)updateViewWithForecast:(WWForecast*)forecast;

@end
