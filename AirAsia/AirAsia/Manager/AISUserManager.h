//
//  AISUserManager.h
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AISCoreDataManager.h"

@interface AISUserManager : NSObject

@property(nonatomic,strong)AISUserDetails *user;

+ (instancetype)sharedInstance;

- (void)getuserDetailsWithCompletion:(void (^)(AISUserDetails *userDetail))completion;

@end