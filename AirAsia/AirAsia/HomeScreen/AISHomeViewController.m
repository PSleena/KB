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

#define MESSAGE_PLACEHOLDER @"Enter your Message"

@interface AISHomeViewController ()<UITextFieldDelegate,UITextViewDelegate,AISSearchTableViewControllerDelegate>
@property(nonatomic,weak)IBOutlet AISUserView *userView;
@property(nonatomic,weak)IBOutlet UITextField *contactTextField;
@property(nonatomic,weak)IBOutlet UITextView *messageTextView;
@property(nonatomic,weak)IBOutlet UIButton *contactPickBtn;
@property(nonatomic,weak)IBOutlet UIButton *sendCardButton;
@property(nonatomic,weak)IBOutlet UIButton *createCardButton;

@property (nonatomic,strong)AISContact *selectedContact;

@end

@implementation AISHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    // Do any additional setup after loading the view.
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
    
    [AISUIUtility setPlaceHolderColor:self.contactTextField placeHoldertext:@"name/email/phone"];
    
    self.contactTextField.delegate = self;
    
    self.contactPickBtn.layer.cornerRadius = 4;
    self.contactPickBtn.layer.masksToBounds = YES;
    [self.contactPickBtn addTarget:self action:@selector(openContactPicker) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendCardButton.layer.cornerRadius = 7;
    self.sendCardButton.layer.masksToBounds = YES;
    
    self.messageTextView.layer.borderWidth = 1;
    self.messageTextView.layer.borderColor = [UIColor redColor].CGColor;
    self.messageTextView.delegate = self;
    self.messageTextView.text = MESSAGE_PLACEHOLDER;
    
    self.createCardButton.layer.cornerRadius = 12;
    self.createCardButton.layer.masksToBounds = YES;
}

- (void)openContactPicker {
    AISSearchTableViewController *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISSearchTableViewController"];
    con.searchString = self.contactTextField.text;
    con.delegate = self;
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

- (void)selectedContact:(AISContact *)contact {
    self.selectedContact = contact;
    self.contactTextField.text = contact.fullName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
