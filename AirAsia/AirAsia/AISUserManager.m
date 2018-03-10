//
//  AISUserManager.m
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISUserManager.h"
#import "UserDetails+CoreDataClass.h"

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

- (void)method {
    
}


@end
