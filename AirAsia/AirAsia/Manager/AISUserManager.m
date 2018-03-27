//
//  AISUserManager.m
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISUserManager.h"

@interface AISUserManager()

@end

@implementation AISUserManager

+ (instancetype)sharedInstance
{
    static AISUserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[AISUserManager alloc] init];
                  });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self getuserDetailsWithCompletion:^(AISUserDetails *userDetail) {
            self.user = userDetail;
        }];
    }
    return self;
}

- (void)getuserDetailsWithCompletion:(void (^)(AISUserDetails *userDetail))completion {
    if (self.user != nil) {
        completion(self.user);
    } else {
        [AISUserDetails getUserDetailsWithMoc:[AISCoreDataManager sharedManager].managedObjectContext withCompletion:^(AISUserDetails * _Nonnull userDetails) {
            completion(userDetails);
        }];
    }
}


@end
