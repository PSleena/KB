//
//  AISUIUtility.m
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISUIUtility.h"
#import "AppDelegate.h"

@implementation AISUIUtility
+ (void)addThemeToView:(UIView *)view {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor whiteColor].CGColor];
    [view.layer insertSublayer:gradient atIndex:0];
}

+ (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [[[UIApplication sharedApplication] delegate].window.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)setPlaceHolderColor:(UITextField *)textField placeHoldertext:(NSString *)text {
    if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor redColor];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: color}];
    }
}


@end
