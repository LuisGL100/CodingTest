//
//  LocationServicesDisabledView.h
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface LocationServicesDisabledView : UIView

@property (nonatomic, readonly) UILabel *textLabel;
@property (nonatomic, readonly) UIButton *openSettingsButton;
@property (nonatomic, readonly) UIButton *manualEntryButton;

- (void)displayLocationDenied;
- (void)displayLocationRestricted;

@end
