//
//  ManualEntryViewController.m
//  WestpacWeather
//
//  Created by Luis López on 11/18/15.
//  Copyright © 2015 luis.org. All rights reserved.
//

#import "ManualEntryViewController.h"

@interface ManualEntryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
@property (weak, nonatomic) IBOutlet UIButton *goButton;

@end

@implementation ManualEntryViewController

- (instancetype)init {
    NSString *nibName = NSStringFromClass([self class]);
    self = [super initWithNibName:nibName bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goButtonTapped:(id)sender {
    NSString *latitude = self.latitudeTextField.text;
    NSString *longitude = self.longitudeTextField.text;
    
    double latF = [latitude doubleValue];
    if (latF > 90.0 || latF < -90.0) {
        [self displayAlertDialogWithMessage:@"The latitude value is invalid; please enter a valid number."];
        return;
    }
    
    double lonF = [longitude doubleValue];
    if (lonF > 180.0 || lonF < -180.0) {
        [self displayAlertDialogWithMessage:@"The longitude value is invalid; please enter a valid number."];
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(manualEntryViewController:didDismissWithLatitude:longitude:)]) {
            [self.delegate manualEntryViewController:self didDismissWithLatitude:latF longitude:lonF];
        }
    }];
}

- (void)displayAlertDialogWithMessage:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
