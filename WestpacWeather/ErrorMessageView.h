//
//  ErrorMessageView.h
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface ErrorMessageView : UIView

@property (nonatomic, readonly) UIView *container;
@property (nonatomic, readonly) UILabel *errorLabel;
@property (nonatomic, readonly) UIButton *retryButton;

@end
