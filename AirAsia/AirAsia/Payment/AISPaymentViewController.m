//
//  AISPaymentViewController.m
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISPaymentViewController.h"
#import "AISSuccessfulPaymentPage.h"
#import "AISFilePathUtility.h"
#import "AirAsia-Bridging-Header.h"
#import "UIImage+MDQRCode.h"
#import "AISVoucher+CoreDataClass.h"
#import "AISCoreDataManager.h"

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
    self.paymentArr = @[@"Credit Card",@"Debit Card",@"Net banking",@"Wallet",@"Rewards"];
    [self setUpView];
}

- (void)setUpView {
    
    [self.payNow addTarget:self action:@selector(goToSuccessfulPaymentPage) forControlEvents:UIControlEventTouchUpInside];
    self.paymentView.layer.borderWidth = 1;
    self.paymentView.layer.borderColor = [UIColor redColor].CGColor;
    self.price.text = self.voucherInfo[@"price"];
}

- (void)goToSuccessfulPaymentPage {
    //get voucherID and QR code details from server.
    UIImage *qrCode = [UIImage mdQRCodeForString:@"Qrcode" size:400];
    NSData *imageData = UIImageJPEGRepresentation(qrCode, 1.0);
    NSString *filePath = [AISFilePathUtility newQRCodePath];
    [imageData writeToFile:filePath atomically:YES];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:self.voucherInfo];
    [dict setValue:filePath forKey:@"qrCodePath"];
    
    [AISVoucher insertOrUpdateVoucherWithID:dict[@"voucherID"]
                                   withInfo:dict
                                        moc:[[AISCoreDataManager sharedManager]managedObjectContext]
                             withCompletion:^(AISVoucher * _Nonnull voucher) {
                                     AISSuccessfulPaymentPage *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISSuccessfulPaymentPage"];
                                     con.voucher = voucher;
                                     [self.navigationController pushViewController:con animated:YES];
                             }];
    
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



@end
