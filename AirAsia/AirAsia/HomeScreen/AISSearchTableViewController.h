//
//  AISSearchTableViewController.h
//  AirAsia
//
//  Created by ATS on 3/26/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AISContact.h"

@protocol AISSearchTableViewControllerDelegate
- (void)selectedContact:(AISContact *)contact;
@end

@interface AISSearchTableViewController : UITableViewController<UISearchResultsUpdating,UISearchBarDelegate>
@property(nonatomic,strong) NSString *searchString;
@property(nonatomic,strong) UISearchController *searchController;
@property(nonatomic,weak) id<AISSearchTableViewControllerDelegate> delegate;
@end
