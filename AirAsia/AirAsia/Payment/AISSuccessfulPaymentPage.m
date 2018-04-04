//
//  AISSuccessfulPaymentPage.m
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISSuccessfulPaymentPage.h"
#import "AISCoreDataManager.h"
#import "AISUserManager.h"

@interface AISSuccessfulPaymentPage ()
@property(nonatomic,weak)IBOutlet UIView *orderView;
@property(nonatomic,weak)IBOutlet UIImageView *cardImageView;
@property(nonatomic,weak)IBOutlet UILabel *price;
@property(nonatomic,weak)IBOutlet UIButton *shareButton;
@property(nonatomic,weak)IBOutlet UIImageView *barCodeImage;

@end

@implementation AISSuccessfulPaymentPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];

    self.orderView.layer.borderWidth = 1;
    self.orderView.layer.borderColor = [UIColor redColor].CGColor;
    [self.shareButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc] initWithTitle:@"Home"
                                                                style:UIBarButtonItemStylePlain target:self action:@selector(moveToHome)];
    self.navigationItem.rightBarButtonItem = nextBtn;
    
    self.price.text = self.voucher.price;
    
    NSString *filePath = self.voucher.qrCodePath;
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    self.barCodeImage.image = image;
    
}

- (void)moveToHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionButtonClicked:(id)sender {
    NSString *filePath = self.voucher.qrCodePath;
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    NSArray *items = @[image];
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
    
    [controller setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType,
                                                BOOL completed,
                                                NSArray * _Nullable returnedItems,
                                                NSError * _Nullable activityError) {
        
        NSString *ServiceMsg = nil;
        if ( [activityType isEqualToString:UIActivityTypeMail] )           ServiceMsg = @"Mail sent";
        if ( [activityType isEqualToString:UIActivityTypePostToTwitter] )  ServiceMsg = @"Post on twitter";
        if ( [activityType isEqualToString:UIActivityTypePostToFacebook] ) ServiceMsg = @"Post on facebook";
        if (ServiceMsg == nil) {
            ServiceMsg = [NSString stringWithFormat:@"Shared with %@",self.voucher.name];
        }
        
        if ( completed )
        {
            [AISVoucher deleteVoucherWithID:self.voucher.voucherID moc:[[AISCoreDataManager sharedManager] managedObjectContext] withCompletion:^(BOOL success) {
                if (success) {
                    [[[AISUserManager sharedInstance] myVouchers] removeObject:self.voucher];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }
        else
        {
            // didn't succeed.
        }
    }];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
