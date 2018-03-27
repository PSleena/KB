//
//  AISUserDetails+CoreDataClass.h
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AISUserDetails : NSManagedObject

+ (void)insertUserDetailsWithUserName:(NSString *)username
                              emailId:(NSString *)email
                             phoneNum:(NSString *)phoneNum
                              fullName:(NSString *)fullname
                               avatar:(NSString *)avatar
                                  moc:(NSManagedObjectContext*)moc
                       withCompletion:(void (^)(BOOL success))completion;

+ (void)getUserDetailsWithMoc:(NSManagedObjectContext*)moc
               withCompletion:(void (^)(AISUserDetails *userDetails))completion;

@end

NS_ASSUME_NONNULL_END

#import "AISUserDetails+CoreDataProperties.h"
