//
//  ViewController.h
//  PasswordSafe
//
//  Created by Timothy Hsu on 1/25/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *programName;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)addButton:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@property NSInteger pID;

@end

