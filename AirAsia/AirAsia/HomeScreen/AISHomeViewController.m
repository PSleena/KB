//
//  AISHomeViewController.m
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISHomeViewController.h"
#import "AISUIUtility.h"
#import "AISUserView.h"
#import "AISSearchTableViewController.h"
#import "AISContact.h"
#import "AISCardCell.h"
#import "AISGiftCardViewController.h"
#import <ContactsUI/ContactsUI.h>
#import "AISUserViewController.h"
#import "NSData+Dictionary.h"
#import "AISVoucherModel.h"
#import "AISSuccessfulPaymentPage.h"
#import "UIImage+MDQRCode.h"
#import "AISFilePathUtility.h"



#define MESSAGE_PLACEHOLDER @"Enter your Message"

@interface AISHomeViewController ()<UITextFieldDelegate,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CNContactPickerDelegate>
@property(nonatomic,weak)IBOutlet AISUserView *userView;
@property(nonatomic,weak)IBOutlet UITextField *contactTextField;
@property(nonatomic,weak)IBOutlet UITextView *messageTextView;
@property(nonatomic,weak)IBOutlet UIButton *contactPickBtn;
@property(nonatomic,weak)IBOutlet UIButton *sendCardButton;
@property(nonatomic,weak)IBOutlet UIButton *createCardButton;
@property(nonatomic,weak)IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *voucherarr;

@property (nonatomic,strong)AISContact *selectedContact;

@end

@implementation AISHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    
    NSDictionary *dic = [AISUIUtility dataFromJsonFileWithName:@"Config"];
    self.voucherarr = [[NSMutableArray alloc] init];
    NSArray *arr = dic[@"voucherDetails"];
    for (NSDictionary *voucher in arr) {
        AISVoucherModel *vObj = [[AISVoucherModel alloc]initWithInfo:voucher];
        [self.voucherarr addObject:vObj];
    }
    [self.collectionView reloadData];
    
}

- (void)setUpUI {
    
    //[AISUIUtility addThemeToView:self.view];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"Home";

    AISUserDetails *user = [AISUserManager sharedInstance].user;
    if (user == nil) {
        [[AISUserManager sharedInstance] getuserDetailsWithCompletion:^(AISUserDetails *userDetail) {
            [self.userView updateViewWithName:[AISUserManager sharedInstance].user.username andAvatarPath:[AISUserManager sharedInstance].user.avatar];
        }];
    }
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.userView addGestureRecognizer:singleFingerTap];
    
    [AISUIUtility setPlaceHolderColor:self.contactTextField placeHoldertext:@"name/email/phone"];
    
    self.contactTextField.delegate = self;
    
    self.contactPickBtn.layer.cornerRadius = 4;
    self.contactPickBtn.layer.masksToBounds = YES;
    [self.contactPickBtn addTarget:self action:@selector(openContactPicker) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendCardButton.layer.cornerRadius = 7;
    self.sendCardButton.layer.masksToBounds = YES;
    [self.sendCardButton addTarget:self action:@selector(openCardView) forControlEvents:UIControlEventTouchUpInside];
    
    self.messageTextView.layer.borderWidth = 1;
    self.messageTextView.layer.borderColor = [UIColor redColor].CGColor;
    self.messageTextView.delegate = self;
    self.messageTextView.text = MESSAGE_PLACEHOLDER;
    
    self.createCardButton.layer.cornerRadius = 12;
    self.createCardButton.layer.masksToBounds = YES;
    
    [self setUpCollectionView];
    
    
}

- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *cardCellViewLayout = [[UICollectionViewFlowLayout alloc] init];
    cardCellViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cardCellViewLayout.minimumLineSpacing = 5.0f;
    cardCellViewLayout.minimumInteritemSpacing = 5.0f;
    
    self.collectionView.collectionViewLayout = cardCellViewLayout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = YES;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    AISUserViewController *vwCon = [self.storyboard instantiateViewControllerWithIdentifier:@"AISUserViewController"];
    [self.navigationController pushViewController:vwCon animated:YES];
}

- (void)openContactPicker {
//    AISSearchTableViewController *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISSearchTableViewController"];
//    con.searchString = self.contactTextField.text;
//    con.delegate = self;
//    [self.navigationController pushViewController:con animated:YES];
    
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactGivenNameKey, CNContactImageDataAvailableKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey, CNContactIdentifierKey];
    contactPicker.predicateForEnablingContact = [NSPredicate predicateWithFormat:@"phoneNumbers.@count > 0"];
    contactPicker.predicateForSelectionOfContact = [NSPredicate predicateWithFormat:@"phoneNumbers.@count == 1"];
    contactPicker.predicateForSelectionOfProperty = [NSPredicate predicateWithFormat:@"key == 'phoneNumbers'"];
    [self presentViewController:contactPicker animated:YES completion:nil];
}

- (void)openCardView {
    if (self.contactTextField.text.length == 0) {
        [AISUIUtility showAlertWithMessage:@"Enter Recipient"];
        return;
    }
    AISGiftCardViewController *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISGiftCardViewController"];
    con.selecteContact = self.selectedContact;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - Collection View delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = collectionView.frame.size.height - 10;
    CGFloat width = height*1.5;
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
    AISCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyOwnCards" forIndexPath:indexPath];
    cell.check.hidden = YES;
    AISVoucherModel *voucher = [self.voucherarr objectAtIndex:indexPath.item];
    cell.price.text = voucher.price;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AISSuccessfulPaymentPage *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISSuccessfulPaymentPage"];
    
    UIImage *qrCode = [UIImage mdQRCodeForString:@"Qrcode" size:400];
    NSData *imageData = UIImageJPEGRepresentation(qrCode, 1.0);
    NSString *filePath = [AISFilePathUtility newQRCodePath];
    [imageData writeToFile:filePath atomically:YES];
    
    con.voucher = [self.voucherarr objectAtIndex:indexPath.item];
    con.voucher.qrCodePath = filePath;
    [self.navigationController pushViewController:con animated:YES];
}


#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - TextView Delegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    self.messageTextView.text = @"";
    self.messageTextView.textColor = [UIColor blackColor];
    return YES;
}

- (void) textViewDidChange:(UITextView *)textView {
    if(self.messageTextView.text.length == 0){
        self.messageTextView.textColor = [UIColor lightGrayColor];
        self.messageTextView.text = MESSAGE_PLACEHOLDER;
        [self.messageTextView resignFirstResponder];
        
        if(self.selectedContact == nil){
            self.selectedContact = [[AISContact alloc] init];
        }
        self.selectedContact.message = textView.text;
    }
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    if(self.messageTextView.text.length == 0){
        self.messageTextView.textColor = [UIColor lightGrayColor];
        self.messageTextView.text = MESSAGE_PLACEHOLDER;
        [self.messageTextView resignFirstResponder];
    }
    return YES;
}

//- (void)selectedContact:(AISContact *)contact {
//    self.selectedContact = contact;
//    self.contactTextField.text = contact.fullName;
//}

# pragma mark - peoplePickerDelegate methods
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    self.selectedContact = nil;
    self.selectedContact = [[AISContact alloc] init];
    
    CNLabeledValue *emailValue = contact.emailAddresses.firstObject;
    NSString *emailString = emailValue.value;
    self.selectedContact.email = emailString;
    
    CNLabeledValue *phoneNumberValue = contact.phoneNumbers.firstObject;
    CNPhoneNumber *phoneNumber = phoneNumberValue.value;
    NSString *phoneNumberString = phoneNumber.stringValue;
    self.selectedContact.phone = phoneNumberString;
    
    NSString *name = contact.givenName;
    self.selectedContact.fullName = name;
    
    self.contactTextField.text = self.selectedContact.phone;
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    self.selectedContact = nil;
    self.selectedContact = [[AISContact alloc] init];
    
    CNLabeledValue *emailValue = contactProperty.contact.emailAddresses.firstObject;
    NSString *emailString = emailValue.value;
    self.selectedContact.email = emailString;
    
    CNLabeledValue *phoneNumberValue = contactProperty.contact.phoneNumbers.firstObject;
    CNPhoneNumber *phoneNumber = phoneNumberValue.value;
    NSString *phoneNumberString = phoneNumber.stringValue;
    self.selectedContact.phone = phoneNumberString;

    NSString *name = contactProperty.contact.givenName;
    self.selectedContact.fullName = name;
    
    self.contactTextField.text = self.selectedContact.phone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
