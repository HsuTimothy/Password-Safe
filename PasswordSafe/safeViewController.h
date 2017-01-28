//
//  safeViewController.h
//  PasswordSafe
//
//  Created by Timothy Hsu on 1/27/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface safeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
