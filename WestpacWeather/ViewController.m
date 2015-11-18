//
//  ViewController.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <SVProgressHUD.h>
#import "LocationServicesDisabledView.h"
#import "ErrorMessageView.h"
#import "WeatherDataProvider.h"
#import "WWForecast.h"
#import "WeatherView.h"
#import "ManualEntryViewController.h"

@interface ViewController () <CLLocationManagerDelegate, ManualEntryViewControllerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) IBOutlet LocationServicesDisabledView *locationDisabledView;
@property (nonatomic, strong) IBOutlet ErrorMessageView *errorMessageView;
@property (nonatomic, strong) IBOutlet WeatherView *weatherView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // This is not a turn-by-turn app so high accuracy is not needed.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    [self.locationDisabledView.openSettingsButton addTarget:self action:@selector(openSettingsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.locationDisabledView.manualEntryButton addTarget:self action:@selector(manualEntryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.errorMessageView.retryButton addTarget:self action:@selector(retryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.weatherView.retryBtn addTarget:self action:@selector(weatherRetryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.weatherView.manualEntryBtn addTarget:self action:@selector(manualEntryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    [self handleLocationAuthStatus:authStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayLocationDeniedScreen {
    self.locationDisabledView.hidden = NO;
    [self.locationDisabledView displayLocationDenied];
    [self.view bringSubviewToFront:self.locationDisabledView];
}

- (void)displayLocationRestrictedScreen {
    self.locationDisabledView.hidden = NO;
    [self.locationDisabledView displayLocationRestricted];
    [self.view bringSubviewToFront:self.locationDisabledView];
}

- (void)hideLocationUnavailableScreen {
    self.locationDisabledView.hidden = YES;
}

- (void)displayErrorMessageViewWithText:(NSString*)message {
    self.errorMessageView.errorLabel.text = message;
    self.errorMessageView.hidden = NO;
    [self.view bringSubviewToFront:self.errorMessageView];
}

- (void)hideErrorMessageView {
    self.errorMessageView.hidden = YES;
}

- (void)displayWeatherViewWithForecast:(WWForecast*)forecast {
    
    [self.weatherView updateViewWithForecast:forecast];
    self.weatherView.hidden = NO;
    [self.view bringSubviewToFront:self.weatherView];
}

- (void)hideWeatherView {
    self.weatherView.hidden = YES;
}

- (void)handleLocationAuthStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            break;
            
        case kCLAuthorizationStatusDenied:
            [self displayLocationDeniedScreen];
            break;
            
        case kCLAuthorizationStatusRestricted:
            [self displayLocationRestrictedScreen];
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self hideLocationUnavailableScreen];
            [SVProgressHUD showWithStatus:@"Obtaining weather information.\nPlease Wait..."];
            [self.locationManager startUpdatingLocation];
            break;
            
        default:
            break;
    }
}

- (void)obtainWeatherInfoForLocationCordinate:(CLLocationCoordinate2D)locationCoordinate {
    
    WWCoordinate coordinate;
    coordinate.latitude = locationCoordinate.latitude;
    coordinate.longitude = locationCoordinate.longitude;
    [WeatherDataProvider fetchWeatherInfoForCoordinate:coordinate onSuccess:^(WWForecast *forecast) {
        [self displayWeatherViewWithForecast:forecast];
        [SVProgressHUD dismiss];
    } onFailure:^(NSError *error) {
        [self displayErrorMessageViewWithText:@"There was a network-related issue."];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self handleLocationAuthStatus:status];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.locationManager stopUpdatingLocation];
    CLLocation *location = [locations firstObject];
    [self obtainWeatherInfoForLocationCordinate:location.coordinate];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
    [self displayErrorMessageViewWithText:@"Unable to obtain location."];
    [SVProgressHUD dismiss];
}

#pragma mark - Target-Action methods
- (void)manualEntryButtonTapped:(id)sender {
    ManualEntryViewController *manualEntryVC = [[ManualEntryViewController alloc] init];
    manualEntryVC.delegate = self;
    [self presentViewController:manualEntryVC
                       animated:YES
                     completion:nil];
}

- (void)openSettingsButtonTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (void)retryButtonTapped:(id)sender {
    [self.locationManager startUpdatingLocation];
}

- (void)weatherRetryButtonTapped:(id)sender {
    [self hideWeatherView];
    [self.locationManager startUpdatingLocation];
}

#pragma mark - ManualEntryViewControllerDelegate methods
- (void)manualEntryViewController:(ManualEntryViewController *)manualEntryViewController
           didDismissWithLatitude:(double)latitude
                        longitude:(double)longitude {
    
    [self hideErrorMessageView];
    [self hideLocationUnavailableScreen];
    [self hideWeatherView];
    
    [SVProgressHUD showWithStatus:@"Obtaining weather information.\nPlease Wait..."];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    [self obtainWeatherInfoForLocationCordinate:coordinate];
}

@end
