//
//  ErrorMessageView.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "ErrorMessageView.h"

@interface ErrorMessageView ()

@property (nonatomic, strong) IBOutlet UIView *container;
@property (nonatomic, strong) IBOutlet UILabel *errorLabel;
@property (nonatomic, strong) IBOutlet UIButton *retryButton;

@end

@implementation ErrorMessageView

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
