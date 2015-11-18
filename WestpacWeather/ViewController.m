//
//  ViewController.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationServicesDisabledView.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) IBOutlet LocationServicesDisabledView *locationDisabledView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationDisabledView.openSettingsButton addTarget:self action:@selector(openSettingsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.locationDisabledView.manualEntryButton addTarget:self action:@selector(manualEntryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
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
}

- (void)displayLocationRestrictedScreen {
    self.locationDisabledView.hidden = NO;
    [self.locationDisabledView displayLocationRestricted];
}

- (void)hideLocationDeniedScreen {
    self.locationDisabledView.hidden = YES;
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
            [self hideLocationDeniedScreen];
            break;
            
        default:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self handleLocationAuthStatus:status];
}

#pragma mark - Target-Action methods
- (void)manualEntryButtonTapped:(id)sender {
    
}

- (void)openSettingsButtonTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
