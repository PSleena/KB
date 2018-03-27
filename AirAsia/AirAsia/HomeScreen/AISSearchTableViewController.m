//
//  AISSearchTableViewController.m
//  AirAsia
//
//  Created by ATS on 3/26/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISSearchTableViewController.h"
#import "AISContactUtility.h"

@interface AISSearchTableViewController ()
@property (nonatomic,strong) NSArray *contactArray;
@property (nonatomic,strong) NSMutableArray *searchResultArray;
@end

@implementation AISSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initilizeSearchController];
    [self getContacts];
}

- (void)initilizeSearchController {
    UITableViewController *searchResultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.delegate = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    self.definesPresentationContext = YES;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    self.searchController.searchBar.barTintColor = [UIColor redColor];
    self.searchController.searchBar.backgroundColor = [UIColor redColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - UITableViewDataSource methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResultArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellReuseId = @"ReuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseId];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellReuseId];
    }
    
    AISContact *contact = [self.searchResultArray objectAtIndex:indexPath.row];
    cell.textLabel.text = contact.fullName;
    
    if(self.searchController.searchBar.text.length > 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AISContact *selectedItem = [self.searchResultArray objectAtIndex:indexPath.row];
    NSLog(@"%@",selectedItem.fullName);
    [self.delegate selectedContact:selectedItem];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [self.searchController.searchBar text];
    if (!([searchText length] > 0)) {
        return;
    } else {
        [self.searchResultArray removeAllObjects];
        self.searchResultArray = nil;
        
        if([searchText length] == 0) {
            self.searchResultArray = [self.contactArray mutableCopy];
        }
        else if(searchText.length > 0) {
            
            //fullName,phone,email
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.fullName CONTAINS[cd] %@ OR SELF.phone CONTAINS[cd] %@ OR SELF.email CONTAINS[cd] %@",searchText,searchText,searchText];
            self.searchResultArray = [NSMutableArray arrayWithArray:[self.contactArray filteredArrayUsingPredicate:predicate]];
        }
        
        [((UITableViewController *)self.searchController.searchResultsController).tableView reloadData];
    }
}

#pragma mark - UISearchBarDelegate methods
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchResultArray removeAllObjects];
    self.searchResultArray = nil;
    self.searchResultArray = [self.contactArray mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - fetchContacts

-(void)getContacts {
    [AISContactUtility getAllMyContactsWithCompletion:^(NSArray *contactList) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.contactArray = contactList;
            self.searchResultArray = [self.contactArray mutableCopy];
            if(self.searchString.length > 0) {
                [self.searchController setActive:YES];
                self.searchController.searchBar.text = self.searchString;
            } else {
                [self.tableView reloadData];
            }
        });
    }];
}


@end
