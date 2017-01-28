//
//  ViewController.m
//  PasswordSafe
//
//  Created by Timothy Hsu on 1/25/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import "ViewController.h"
#import "safeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _programName.frame.size.height - borderWidth, _programName.frame.size.width, _programName.frame.size.height);
    border.borderWidth = borderWidth;
    [_programName.layer addSublayer:border];
    _programName.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 2;
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, _usernameTextField.frame.size.height - borderWidth, _usernameTextField.frame.size.width, _usernameTextField.frame.size.height);
    border2.borderWidth = borderWidth2;
    [_usernameTextField.layer addSublayer:border2];
    _usernameTextField.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 2;
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.frame = CGRectMake(0, _passwordTextField.frame.size.height - borderWidth, _passwordTextField.frame.size.width, _passwordTextField.frame.size.height);
    border3.borderWidth = borderWidth3;
    [_passwordTextField.layer addSublayer:border3];
    _passwordTextField.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(id)sender {
    NSLog(@"Add button pressed");
    
    NSString *program = [self.programName text];
    NSString *username = [self.usernameTextField text];
    NSString *password = [self.passwordTextField text];
    
    NSLog(@"program: %@ username: %@ password: %@", program, username, password);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // IF THE DATA ALREADY EXISTS, IT WILL GO IN HERE
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"programsKey"]){
        NSLog(@"programsKey found");
        
        // Retrieves my stored data
        NSMutableArray *programsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"programsKey"]];
        NSMutableArray *usernamesArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"usernamesKey"]];
        NSMutableArray *passwordsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"passwordsKey"]];
        
        // Add my new text fields to my arrays
        [programsArray addObject:[NSString stringWithFormat:@"%@", program]];
        [usernamesArray addObject:[NSString stringWithFormat:@"%@", username]];
        [passwordsArray addObject:[NSString stringWithFormat:@"%@", password]];
        
        // Saves my NSMutable arrays
        [defaults setObject:programsArray forKey:@"programsKey"];
        [defaults setObject:usernamesArray forKey:@"usernamesKey"];
        [defaults setObject:passwordsArray forKey:@"passwordsKey"];
        
        NSLog(@"Programs Array - %@", programsArray);
        NSLog(@"Usernames Array - %@", usernamesArray);
        NSLog(@"Passwords Array - %@", passwordsArray);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSMutableArray *programsToSave =  [[NSMutableArray alloc] init];
        [programsToSave addObject:[NSString stringWithFormat:@"%@", program]];
        NSMutableArray *usernamesToSave =  [[NSMutableArray alloc] init];
        [usernamesToSave addObject:[NSString stringWithFormat:@"%@", username]];
        NSMutableArray *passwordsToSave =  [[NSMutableArray alloc] init];
        [passwordsToSave addObject:[NSString stringWithFormat:@"%@", password]];
        // Saves my NSMutable arrays
        [defaults setObject:programsToSave forKey:@"programsKey"];
        [defaults setObject:usernamesToSave forKey:@"usernamesKey"];
        [defaults setObject:passwordsToSave forKey:@"passwordsKey"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
