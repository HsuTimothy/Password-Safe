//
//  editInfoViewController.h
//  PasswordSafe
//
//  Created by Timothy Hsu on 2/4/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface editInfoViewController : UIViewController
@property NSInteger pID;
- (IBAction)doneButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *programTextField;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end
