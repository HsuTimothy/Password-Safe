//
//  displayViewController.h
//  PasswordSafe
//
//  Created by Timothy Hsu on 1/27/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface displayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *usernameTextField;
@property (weak, nonatomic) IBOutlet UILabel *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *programTextField;

@property NSInteger pID;

@end
