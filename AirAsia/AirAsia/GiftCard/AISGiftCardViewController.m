//
//  AISGiftCardViewController.m
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISGiftCardViewController.h"
#import "AISUserManager.h"
#import "AISCardCell.h"
#import "AISPaymentViewController.h"
#import "AISUIUtility.h"
#import "AISVoucher+CoreDataClass.h"

@interface AISGiftCardViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak)IBOutlet UITextField *nameField;
@property (nonatomic,weak)IBOutlet UITextField *amountField;
@property (nonatomic,weak)IBOutlet UICollectionView *cardCollectionView;
@property(nonatomic,strong)NSMutableArray *voucherarr;
@property(nonatomic,strong)NSDictionary *selectedVoucher;

@end

@implementation AISGiftCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self setUpDatasource];
    [self.cardCollectionView reloadData];

}

- (void)setUpUI {
    
    UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                             style:UIBarButtonItemStylePlain target:self action:@selector(moveToPayment)];
    self.navigationItem.rightBarButtonItem = nextBtn;
    
    self.nameField.text = self.selecteContact.fullName;
    
    UICollectionViewFlowLayout *cardCellViewLayout = [[UICollectionViewFlowLayout alloc] init];
    cardCellViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    cardCellViewLayout.minimumLineSpacing = 5.0f;
    cardCellViewLayout.minimumInteritemSpacing = 5.0f;
    
    self.cardCollectionView.collectionViewLayout = cardCellViewLayout;
    self.cardCollectionView.delegate = self;
    self.cardCollectionView.dataSource = self;
    self.cardCollectionView.showsVerticalScrollIndicator = YES;
    self.cardCollectionView.backgroundColor = [UIColor clearColor];
    

}

- (void)setUpDatasource {
    NSDictionary *dic = [AISUIUtility dataFromJsonFileWithName:@"voucherListFromServer"];
    self.voucherarr = [[NSMutableArray alloc] init];
    NSArray *arr = dic[@"vouchers"];
    for (NSDictionary *voucher in arr) {
        [self.voucherarr addObject:voucher];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (collectionView.frame.size.width/2)-(5.0 * 3);
    CGFloat height = (3*width)/4.0;
    return CGSizeMake(width,height);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.voucherarr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AISCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AISCardCell" forIndexPath:indexPath];
    cell.check.hidden = YES;
    cell.price.hidden =YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedVoucher = [self.voucherarr objectAtIndex:indexPath.item];
    AISCardCell *cell = (AISCardCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.check.hidden = NO;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    AISCardCell *cell = (AISCardCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.check.hidden = YES;
}

- (void)moveToPayment {
    if (self.selectedVoucher == nil) {
        [AISUIUtility showAlertWithMessage:@"Select card to proceed"];
        return;
    }
    if (self.amountField.text.length == 0) {
        [AISUIUtility showAlertWithMessage:@"Enter Amount"];
        return;
    }
    
    AISPaymentViewController *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISPaymentViewController"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:self.selectedVoucher];
    [dict setValue:self.amountField.text forKey:@"price"];
    [dict setValue:self.selecteContact.fullName forKey:@"name"];
    [dict setValue:self.selecteContact.phone forKey:@"phone"];
    [dict setValue:self.selecteContact.message forKey:@"message"];
    con.voucherInfo = dict;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
