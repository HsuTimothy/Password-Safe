//
//  editInfoViewController.m
//  PasswordSafe
//
//  Created by Timothy Hsu on 2/4/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import "editInfoViewController.h"
#import "safeViewController.h"

@interface editInfoViewController ()

@end

@implementation editInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _programTextField.frame.size.height - borderWidth, _programTextField.frame.size.width, _programTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [_programTextField.layer addSublayer:border];
    _programTextField.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 0.5;
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, _usernameTextField.frame.size.height - borderWidth, _usernameTextField.frame.size.width, _usernameTextField.frame.size.height);
    border2.borderWidth = borderWidth2;
    [_usernameTextField.layer addSublayer:border2];
    _usernameTextField.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 0.5;
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.frame = CGRectMake(0, _passwordTextField.frame.size.height - borderWidth, _passwordTextField.frame.size.width, _passwordTextField.frame.size.height);
    border3.borderWidth = borderWidth3;
    [_passwordTextField.layer addSublayer:border3];
    _passwordTextField.layer.masksToBounds = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *programsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"programsKey"]];
    NSMutableArray *usernamesArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"usernamesKey"]];
    NSMutableArray *passwordsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"passwordsKey"]];
    
    NSString *program = [programsArray objectAtIndex:_pID];
    NSString *username = [usernamesArray objectAtIndex:_pID];
    NSString *password = [passwordsArray objectAtIndex:_pID];
    
    _programTextField.text = program;
    _usernameTextField.text = username;
    _passwordTextField.text = password;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneButtonPressed:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *programsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"programsKey"]];
    NSMutableArray *usernamesArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"usernamesKey"]];
    NSMutableArray *passwordsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"passwordsKey"]];
    
    NSString *programUpdate = _programTextField.text;
    NSString *usernameUpdate = _usernameTextField.text;
    NSString *passwordUpdate = _passwordTextField.text;
    
    
    // Updates my arrays that hold the account information
    [programsArray replaceObjectAtIndex:_pID withObject: programUpdate];
    [usernamesArray replaceObjectAtIndex:_pID withObject: usernameUpdate];
    [passwordsArray replaceObjectAtIndex:_pID withObject: passwordUpdate];
    
    // Saves it to data
    [defaults setObject:programsArray forKey:@"programsKey"];
    [defaults setObject:usernamesArray forKey:@"usernamesKey"];
    [defaults setObject:passwordsArray forKey:@"passwordsKey"];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
