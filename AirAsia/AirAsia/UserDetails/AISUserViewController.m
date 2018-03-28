//
//  AISUserViewController.m
//  AirAsia
//
//  Created by ATS on 3/28/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISUserViewController.h"
#import "AISUserDetails+CoreDataClass.h"
#import "AISUserManager.h"
#import "AISLoginViewController.h"
#import "AISConstants.h"

@interface AISUserViewController ()
@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (nonatomic,weak)IBOutlet UIButton *logOutButton;

@end

@implementation AISUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)logOutAction:(id)sender {
    AISLoginViewController *vwCon = [self.storyboard instantiateViewControllerWithIdentifier:@"AISLoginViewController"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kUserDefaultuserLogin];
    [[AISUserManager sharedInstance] setUser:nil];
    [AISUserDetails deleteUserDetailsWithMoc:[AISCoreDataManager sharedManager].managedObjectContext withCompletion:^(BOOL success) {
    }];
    [[[UIApplication sharedApplication]delegate].window setRootViewController:vwCon];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    AISUserDetails *user = [[AISUserManager sharedInstance] user];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = user.fullName;
            break;
        case 1:
            cell.textLabel.text = user.phoneNumber;
            break;
        case 2:
            cell.textLabel.text = user.email;
            break;
        case 3:
            cell.textLabel.text = user.username;
            break;
        default:
            break;
    }
    return cell;
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
