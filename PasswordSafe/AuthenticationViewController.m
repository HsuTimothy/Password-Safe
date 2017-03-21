//
//  AuthenticationViewController.m
//  PasswordSafe
//
//  Created by Timothy Hsu on 1/26/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import "AuthenticationViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "VENTouchLock.h"

@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self callAuthenticate];
}



-(void)callAuthenticate {
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Please Enter Touch ID";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self performSegueWithIdentifier:@"showList" sender:nil];
                                    });
                                } else if (error){
                                    NSString *errorMessage;
                                    BOOL showError = NO;
                                    switch (error.code) {
                                        case LAErrorAuthenticationFailed:
                                            errorMessage = @"Sorry couldn't autheticate";
                                            showError = YES;
                                            break;
                                        case LAErrorPasscodeNotSet:
                                            errorMessage = @"No Passcode has been set";
                                            showError = YES;
                                            break;
                                        case LAErrorTouchIDNotEnrolled:
                                            errorMessage = @"Touch ID has no enrolled fingers";
                                            showError = YES;
                                            break;
                                        case LAErrorUserCancel:
                                            [self callAuthenticate];
                                        default:
                                            showError = NO;
                                            break;
                                    }
                                    if (showError) {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                        message:errorMessage
                                                                                       delegate:nil
                                                                              cancelButtonTitle:@"Ok"
                                                                              otherButtonTitles:nil];
                                        [alert show];
                                        
                                    }
                                }
                            }];
    } else {
        [self performSegueWithIdentifier:@"showList" sender:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
