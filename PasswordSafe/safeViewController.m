//
//  safeViewController.m
//  PasswordSafe
//
//  Created by Timothy Hsu on 1/27/17.
//  Copyright © 2017 Timothy Hsu. All rights reserved.
//

#import "safeViewController.h"
#import "displayViewController.h"
#import "ViewController.h"
#import "editInfoViewController.h"

@interface safeViewController ()

@end

@implementation safeViewController {
    NSArray *searchResults;
}
- (IBAction)goToSettings:(id)sender {
    [self performSegueWithIdentifier:@"showSettings" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self editButtonItem];
    _tableView.allowsSelectionDuringEditing = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_data) name:@"reload_data" object:nil];
    // Do any additional setup after loading the view.
}

-(void)handle_data {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *programsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"programsKey"]];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [programsArray count];
        
    }
    
    //return [programsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *programsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"programsKey"]];
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [programsArray objectAtIndex:indexPath.row];
    }
    
    //cell.textLabel.text = [programsArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Your Programs";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tableView.editing == YES) {
        [self performSegueWithIdentifier:@"showEdit" sender:tableView];
    } else {
        [self performSegueWithIdentifier:@"showProgram" sender:tableView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addData"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    } else if ([self.searchDisplayController isActive] && [segue.identifier isEqualToString:@"showProgram"]) {
        NSIndexPath *path = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        displayViewController *vc = (displayViewController *)[segue destinationViewController];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *programsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"programsKey"]];
        NSString *programName = [searchResults objectAtIndex:path.row];
        int index = [programsArray indexOfObject:programName];
        vc.pID = index;
    } else if ([segue.identifier isEqualToString:@"showProgram"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        displayViewController *vc = (displayViewController *)[segue destinationViewController];
        vc.pID = path.row;
    } else if ([segue.identifier isEqualToString:@"showEdit"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editInfoViewController *vc = (editInfoViewController *)[segue destinationViewController];
        vc.pID = path.row;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *programsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"programsKey"]];
        NSMutableArray *usernamesArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"usernamesKey"]];
        NSMutableArray *passwordsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"passwordsKey"]];
        
        [programsArray removeObjectAtIndex:indexPath.row];
        [usernamesArray removeObjectAtIndex:indexPath.row];
        [passwordsArray removeObjectAtIndex:indexPath.row];
        
        [defaults setObject:programsArray forKey:@"programsKey"];
        [defaults setObject:usernamesArray forKey:@"usernamesKey"];
        [defaults setObject:passwordsArray forKey:@"passwordsKey"];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData]; // tell table to refresh now
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *programsArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"programsKey"]];
    searchResults = [programsArray filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];
}

@end
