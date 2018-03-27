//
//  AISSuccessfulPaymentPage.m
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISSuccessfulPaymentPage.h"

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
    
    self.orderView.layer.borderWidth = 1;
    self.orderView.layer.borderColor = [UIColor redColor].CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
