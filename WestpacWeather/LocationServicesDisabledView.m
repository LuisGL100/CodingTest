//
//  LocationServicesDisabledView.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "LocationServicesDisabledView.h"

#define kOpenSettingsBtnTop         30
#define kOpenSettingsBtnHeight      30
#define kOrLabelTop                 27
#define kOrLabelHeight              21
#define kManualEntryBtnTop          20

@interface LocationServicesDisabledView ()

@property (nonatomic, strong) IBOutlet UIView *container;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) IBOutlet UIButton *openSettingsButton;
@property (nonatomic, strong) IBOutlet UIButton *manualEntryButton;

// constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *openSettingsBtnTopCstr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *openSettingsBtnHeightCstr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orLblTopCstr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orLblHeightCstr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *manualEntryBtnTopCstr;


@end

@implementation LocationServicesDisabledView

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

- (void)displayLocationDenied  {
    self.textLabel.text = @"The application doesn't have permission to use Location Services. You can change this preference in the Settings page or try manually entering a latitude or longitude";
    self.openSettingsBtnTopCstr.constant = kOpenSettingsBtnTop;
    self.openSettingsBtnHeightCstr.constant = kOpenSettingsBtnHeight;
    self.openSettingsButton.hidden = NO;
    self.orLblTopCstr.constant = kOrLabelTop;
    self.orLblHeightCstr.constant = kOrLabelHeight;
    [self layoutIfNeeded];
}

- (void)displayLocationRestricted {
    self.textLabel.text = @"Location Services are not available at the moment. You could try manually entering a latitude and longitude";
    self.openSettingsBtnTopCstr.constant = 0;
    self.openSettingsBtnHeightCstr.constant = 0;
    self.openSettingsButton.hidden = YES;
    self.orLblTopCstr.constant = 0;
    self.orLblHeightCstr.constant = 0;
    [self layoutIfNeeded];
}

@end
