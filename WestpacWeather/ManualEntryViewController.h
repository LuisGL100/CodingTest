//
//  ManualEntryViewController.h
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ManualEntryViewController;

@protocol ManualEntryViewControllerDelegate <NSObject>

- (void)manualEntryViewController:(ManualEntryViewController*)manualEntryViewController didDismissWithLatitude:(double)latitude longitude:(double)longitude;

@end

@interface ManualEntryViewController : UIViewController

@property (nonatomic, weak) id<ManualEntryViewControllerDelegate> delegate;

@end
