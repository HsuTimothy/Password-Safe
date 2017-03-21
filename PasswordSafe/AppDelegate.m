//
//  AppDelegate.m
//  PasswordSafe
//
//  Created by Timothy Hsu on 1/25/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import "AppDelegate.h"
#import <VENTouchLock/VENTouchLock.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[VENTouchLock sharedInstance] setKeychainService:@"Account Information Safe"
                                      keychainAccount:@"User"
                                        touchIDReason:@"Touch to Authenticate"
                                 passcodeAttemptLimit:-1
                            splashViewControllerClass:[VENTouchLockSplashViewController class]];
    
    return YES;
}

-(BOOL)callAuthenticate {
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Please Enter Touch ID";
    BOOL val = false;
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                    });
                                    BOOL *val = true;
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
                                            errorMessage = @"Pressed Cancel";
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
        return false;
    }
    return val;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
