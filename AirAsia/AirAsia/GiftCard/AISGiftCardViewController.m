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

@interface AISGiftCardViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak)IBOutlet UITextField *nameField;
@property (nonatomic,weak)IBOutlet UITextField *amountField;
@property (nonatomic,weak)IBOutlet UICollectionView *cardCollectionView;
@end

@implementation AISGiftCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self setUpDatasource];
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
    
    [self.cardCollectionView reloadData];

}

- (void)setUpDatasource {
    
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
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AISCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AISCardCell" forIndexPath:indexPath];
    cell.check.hidden = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AISCardCell *cell = (AISCardCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.check.hidden = NO;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    AISCardCell *cell = (AISCardCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.check.hidden = YES;
}

- (void)moveToPayment {
    AISPaymentViewController *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISPaymentViewController"];
    [self.navigationController pushViewController:con animated:YES];
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
