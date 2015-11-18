//
//  WeatherView.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "WeatherView.h"
#import "WWForecast.h"
#import "WWCurrently.h"

@interface WeatherView ()

@property (nonatomic, strong) IBOutlet UIView *container;
@property (nonatomic, strong) IBOutlet UIImageView *weatherImageView;
@property (nonatomic, strong) IBOutlet UILabel *summaryLabel;
@property (nonatomic, strong) IBOutlet UILabel *precipProbability;
@property (nonatomic, strong) IBOutlet UILabel *temperature;
@property (nonatomic, strong) IBOutlet UILabel *humidity;
@property (nonatomic, strong) IBOutlet UIButton *retryBtn;
@property (nonatomic, strong) IBOutlet UIButton *manualEntryBtn;

@end

@implementation WeatherView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeSubviews];
    }
    return self;
}

- (void)initializeSubviews {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *nibName = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
    [nib instantiateWithOwner:self options:nil];
    self.container.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.container.frame = self.bounds;
    [self addSubview:self.container];
}

- (void)updateViewWithForecast:(WWForecast*)forecast {
    WWCurrently *currently = forecast.currently;
    if (currently) {
        self.weatherImageView.image = [self imageforIconType:currently.iconType];
        self.summaryLabel.text = currently.summary;
        self.precipProbability.text = [NSString stringWithFormat:@"Precip. Probability: %@%%", currently.precipProbability];
        self.temperature.text = [NSString stringWithFormat:@"Temperature: %@", currently.temperature];
        self.humidity.text = [NSString stringWithFormat:@"Humidity: %@", currently.humidity];
    }
}

- (UIImage*)imageforIconType:(IconType)iconType {
    switch (iconType) {
        case IconTypeClearDay:
            return [UIImage imageNamed:@"clear_day"];
            
        case IconTypeClearNight:
            return [UIImage imageNamed:@"clear_night"];
            
        case IconTypeCloudy:
            return [UIImage imageNamed:@"cloudy"];
            
        case IconTypeFog:
            return [UIImage imageNamed:@"fog"];
            
        case IconTypePartlyCloudyDay:
            return [UIImage imageNamed:@"partly_cloudy_day"];
            
        case IconTypePartlyCloudyNight:
            return [UIImage imageNamed:@"partly_cloudy_night"];
            
        case IconTypeRain:
            return [UIImage imageNamed:@"rain"];
            
        case IconTypeSleet:
            return [UIImage imageNamed:@"sleet"];
            
        case IconTypeSnow:
            return [UIImage imageNamed:@"snow"];
            
        case IconTypeWind:
            return [UIImage imageNamed:@"wind"];
            
        default:
            return [UIImage imageNamed:@"question_mark"];
    }
}

@end
