//
//  AISLoginViewController.m
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISLoginViewController.h"
#import "AISHomeViewController.h"
#import "AISCoreDataManager.h"
#import "AISUIUtility.h"
#import "AISConstants.h"
#import "NSData+Dictionary.h"
#import "AppDelegate.h"

@interface AISLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,weak)IBOutlet UITextField *username;
@property (nonatomic,weak)IBOutlet UITextField *password;
@property (nonatomic,weak)IBOutlet UIButton *loginButton;
@end

@implementation AISLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupValues];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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

- (void)setupValues {
    self.username.placeholder = @"Username";
    [self setPlaceHolderColor:self.username placeHoldertext:@"Username"];
    self.password.placeholder = @"Password";
    [self setPlaceHolderColor:self.password placeHoldertext:@"Password"];
    [AISUIUtility addThemeToView:self.view];
}

- (void)setPlaceHolderColor:(UITextField *)textField placeHoldertext:(NSString *)text {
    if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: color}];
    }
}

- (IBAction)Login:(id)sender {
    if (self.username.text.length == 0 || self.password.text.length == 0) {
        [AISUIUtility showAlertWithMessage:@"Something Went wrong"];
        return;
    } else {
        NSDictionary *loginDetails = [AISUIUtility dataFromJsonFileWithName:@"login"];
        if (![self.username.text isEqualToString:loginDetails[@"userName"]]) {
            NSLog(@"Mistmatch in username");
            return;
        }
        
        if (![self.password.text isEqualToString:loginDetails[@"password"]]) {
            NSLog(@"Mistmatch in password");
            return;
        }
        
        NSDictionary *dic = [AISUIUtility dataFromJsonFileWithName:@"loginResponse"];
        [[AISCoreDataManager sharedManager] saveUserInfo:dic withCompletion:^(BOOL success) {
            if (success) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserDefaultuserLogin];
                AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
                [delegate fetchConfig];
                [self goToHomeScreen];
            }
        }];
    }
}

- (void)goToHomeScreen {
    AISHomeViewController *con = [self.storyboard instantiateViewControllerWithIdentifier:@"AISHomeViewController"];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:con];
    [self presentViewController:nav animated:YES completion:nil];
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
