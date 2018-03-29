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
#import "AISVoucher+CoreDataClass.h"
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMyCards) name:@"ConfigComplete" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self loadMyCards];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

- (void)loadMyCards {
    self.voucherarr = [AISUserManager sharedInstance].myVouchers;
    [self.collectionView reloadData];
}

- (void)setUpUI {
    
    //[AISUIUtility addThemeToView:self.view];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"Home";

    AISUserDetails *user = [AISUserManager sharedInstance].user;
    if (user == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            [[AISUserManager sharedInstance] getuserDetailsWithCompletion:^(AISUserDetails *userDetail) {
                NSLog(@"%@",userDetail.username);
                [self.userView updateViewWithName:userDetail.username andAvatarPath:[AISUserManager sharedInstance].user.avatar];
            }];
        });
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
    contactPicker.displayedPropertyKeys = @[CNContactGivenNameKey, CNContactImageDataAvailableKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey, CNContactIdentifierKey,CNContactEmailAddressesKey];
    contactPicker.predicateForEnablingContact = [NSPredicate predicateWithFormat:@"phoneNumbers.@count > 0"];
    contactPicker.predicateForSelectionOfContact = [NSPredicate predicateWithFormat:@"phoneNumbers.@count == 1"];
    contactPicker.predicateForSelectionOfProperty = [NSPredicate predicateWithFormat:@"key == 'phoneNumbers'"];
    
    contactPicker.predicateForEnablingContact = [NSPredicate predicateWithFormat:@"emailAddresses.@count > 0"];
    contactPicker.predicateForSelectionOfContact = [NSPredicate predicateWithFormat:@"emailAddresses.@count == 1"];
    contactPicker.predicateForSelectionOfProperty = [NSPredicate predicateWithFormat:@"key == 'emailAddresses'"];
    
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
    AISVoucher *voucher = [self.voucherarr objectAtIndex:indexPath.item];
    cell.price.text = voucher.price;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *qrCode = [UIImage mdQRCodeForString:@"Qrcode" size:400];
    NSData *imageData = UIImageJPEGRepresentation(qrCode, 1.0);
    NSString *filePath = [AISFilePathUtility newQRCodePath];
    [imageData writeToFile:filePath atomically:YES];
    AISVoucher *voucher = [self.voucherarr objectAtIndex:indexPath.item];
    voucher.qrCodePath = filePath;
    
    AISSuccessfulPaymentPage *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISSuccessfulPaymentPage"];
    con.voucher = voucher;
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

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
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
    
    CNContact *contact = contactProperty.contact;
    NSString *phoneNumberString = nil;
    if (contact.phoneNumbers) {
        for (CNLabeledValue *label in contact.phoneNumbers) {
            phoneNumberString = [label.value stringValue];
            if ([phoneNumberString length] > 0) {
                self.selectedContact.phone = phoneNumberString;
            }
        }
    }
    ////Get all E-Mail addresses from contacts
    NSString *emailString = nil;
    if (contact.emailAddresses) {
        for (CNLabeledValue *label in contact.emailAddresses) {
            emailString = label.value;
            if ([emailString length] > 0) {
                self.selectedContact.email = emailString;
            }
        }
    }
    
    NSString *name = contactProperty.contact.givenName;
    self.selectedContact.fullName = name;
    
    self.contactTextField.text = self.selectedContact.phone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
