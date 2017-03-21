//
//  LockSplashViewController.m
//  PasswordSafe
//
//  Created by Timothy Hsu on 3/16/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import "LockSplashViewController.h"

@interface LockSplashViewController ()

@end

@implementation LockSplashViewController

- (instancetype)init
{
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.didFinishWithSuccess = ^(BOOL success, VENTouchLockSplashViewControllerUnlockType unlockType) {
            if (success) {
                NSString *logString = @"Sample App Unlocked";
                switch (unlockType) {
                    case VENTouchLockSplashViewControllerUnlockTypeTouchID: {
                        logString = [logString stringByAppendingString:@" with Touch ID."];
                        break;
                    }
                    case VENTouchLockSplashViewControllerUnlockTypePasscode: {
                        logString = [logString stringByAppendingString:@" with Passcode."];
                        break;
                    }
                    default:
                        break;
                }
                NSLog(@"%@", logString);
            }
            else {
                [[[UIAlertView alloc] initWithTitle:@"Limit Exceeded"
                                            message:@"You have exceeded the maximum number of passcode attempts"
                                           delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
            }
        };
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
