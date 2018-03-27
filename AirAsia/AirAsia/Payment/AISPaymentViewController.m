//
//  AISPaymentViewController.m
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISPaymentViewController.h"
#import "AISSuccessfulPaymentPage.h"

@interface AISPaymentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UIView *paymentView;
@property(nonatomic,weak)IBOutlet UIImageView *cardImageView;
@property(nonatomic,weak)IBOutlet UILabel *price;
@property(nonatomic,weak)IBOutlet UIButton *payNow;
@property (nonatomic,strong) NSArray *paymentArr;
@end

@implementation AISPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Order Details";
    self.paymentArr = @[@"Credit Card",@"Debit Card",@"Net banking",@"Wallet"];
    
    [self setUpView];
}

- (void)setUpView {
    
    [self.payNow addTarget:self action:@selector(goToSuccessfulPaymentPage) forControlEvents:UIControlEventTouchUpInside];
    
    self.paymentView.layer.borderWidth = 1;
    self.paymentView.layer.borderColor = [UIColor redColor].CGColor;
    
}

- (void)goToSuccessfulPaymentPage {
    AISSuccessfulPaymentPage *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISSuccessfulPaymentPage"];
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.paymentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentModeCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.paymentArr objectAtIndex:indexPath.row];
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
