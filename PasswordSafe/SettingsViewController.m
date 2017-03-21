//
//  SettingsViewController.m
//  
//
//  Created by Timothy Hsu on 3/16/17.
//
//

#import "SettingsViewController.h"
#import "VENTouchLock.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (IBAction)setPassword:(id)sender {
    if ([[VENTouchLock sharedInstance] isPasscodeSet]) {
        NSLog(@"AH");
        [[[UIAlertView alloc] initWithTitle:@"Passcode already exists" message:@"To set a new one, first delete the existing one" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else {
        VENTouchLockCreatePasscodeViewController *createPasscodeVC = [[VENTouchLockCreatePasscodeViewController alloc] init];
        [self presentViewController:[createPasscodeVC embeddedInNavigationController] animated:YES completion:nil];
    }
}


- (IBAction)deletePasscode:(id)sender {
    if ([[VENTouchLock sharedInstance] isPasscodeSet]) {
        [[VENTouchLock sharedInstance] deletePasscode];
         [[[UIAlertView alloc] initWithTitle:@"Passcode Deleted" message:@"It is recommended to have a passcode." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"No passcode" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
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
