//
//  AISUserView.h
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AISUserManager.h"

@interface AISUserView : UIView

- (instancetype)initWithName:(NSString *)name andAvatarPath:(NSString *)path;
- (void)updateViewWithName:(NSString *)name andAvatarPath:(NSString *)path;

@end
