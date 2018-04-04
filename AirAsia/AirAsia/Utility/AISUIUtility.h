//
//  AISUIUtility.h
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AISUIUtility : NSObject
+ (void)addThemeToView:(UIView *)view;
+ (void)showAlertWithMessage:(NSString *)message;
+ (void)setPlaceHolderColor:(UITextField *)textField placeHoldertext:(NSString *)text;
+ (NSDictionary *)dataFromJsonFileWithName:(NSString *)name;
+ (NSString *)stringFromDictionary:(NSDictionary *)dic;
@end
