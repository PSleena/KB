//
//  UserDetails+CoreDataClass.h
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDetails : NSManagedObject
+ (void)insertUserDetailsWithUserName:(NSString *)username
                              emailId:(NSString *)email
                             phoneNum:(NSString *)phoneNum
                       withCompletion:(void (^)(BOOL success))completion;

+ (void)getUserDetailsWithCompletion:(void (^)(UserDetails *userDetails))completion;

@end

NS_ASSUME_NONNULL_END

#import "UserDetails+CoreDataProperties.h"
