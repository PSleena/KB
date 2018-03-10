//
//  ViewController.m
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "ViewController.h"
#import "UserDetails+CoreDataClass.h"
#import "AISHomeViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic,weak)IBOutlet UITextField *username;
@property (nonatomic,weak)IBOutlet UITextField *password;
@property (nonatomic,weak)IBOutlet UIButton *loginButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupValues];
    
}

- (void)setupValues {
    self.username.placeholder = @"Username";
    [self setPlaceHolderColor:self.username placeHoldertext:@"Username"];
    self.password.placeholder = @"Password";
    [self setPlaceHolderColor:self.password placeHoldertext:@"Password"];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = self.view.bounds;
    gradient.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor whiteColor].CGColor];
    [self.view.layer insertSublayer:gradient atIndex:0];

}

- (void)setPlaceHolderColor:(UITextField *)textField placeHoldertext:(NSString *)text {
    if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: color}];
    }
}

- (IBAction)Login:(id)sender {
    if (self.username.text.length == 0 || self.password.text.length == 0) {
        //Show Alert
        return;
    } else {
        //save to database
//        [UserDetails insertUserDetailsWithUserName:self.username.text
//                                           emailId:@"leena@hike.in"
//                                          phoneNum:@"9742999780"
//                                    withCompletion:^(BOOL success) {
//                                        if (success) {
//                                            [self goToHomeScreen];
//                                        }
//                                    }];
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


@end
