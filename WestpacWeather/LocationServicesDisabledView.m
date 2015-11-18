//
//  LocationServicesDisabledView.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "LocationServicesDisabledView.h"

@interface LocationServicesDisabledView ()

@property (nonatomic, strong) IBOutlet UIView *container;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) IBOutlet UIButton *openSettingsButton;
@property (nonatomic, strong) IBOutlet UIButton *manualEntryButton;

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

@end
