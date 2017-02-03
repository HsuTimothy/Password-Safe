//
//  displayViewController.m
//  PasswordSafe
//
//  Created by Timothy Hsu on 1/27/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import "displayViewController.h"
#import "safeViewController.h"

@interface displayViewController ()

@end

@implementation displayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Retrieves my stored data
    NSMutableArray *programsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"programsKey"]];
    NSMutableArray *usernamesArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"usernamesKey"]];
    NSMutableArray *passwordsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"passwordsKey"]];
    
    NSString *program = [programsArray objectAtIndex:_pID];
    NSString *username = [usernamesArray objectAtIndex:_pID];
    NSString *password = [passwordsArray objectAtIndex:_pID];

    _usernameTextField.text = [NSString stringWithFormat: @"%@", username];
    _passwordTextField.text = [NSString stringWithFormat: @"%@", password];
    _usernameTextField.adjustsFontSizeToFitWidth = YES;
    _usernameTextField.minimumFontSize = 1;
    _passwordTextField.adjustsFontSizeToFitWidth = YES;
    _passwordTextField.minimumFontSize = 1;
    
    self.title = program;
    
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
