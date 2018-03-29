//
//  AISUserDetails+CoreDataClass.m
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import "AISUserDetails+CoreDataClass.h"

@implementation AISUserDetails

+ (void)insertUserDetailsWithUserName:(NSString *)username
                              emailId:(NSString *)email
                             phoneNum:(NSString *)phoneNum
                             fullName:(NSString *)fullname
                               avatar:(NSString *)avatar
                                  moc:(NSManagedObjectContext*)moc
                       withCompletion:(void (^)(BOOL success))completion {
    
    [moc performBlock:^{
        AISUserDetails *user = [NSEntityDescription insertNewObjectForEntityForName:@"AISUserDetails" inManagedObjectContext:moc];
        user.username = username;
        user.email = email;
        user.phoneNumber = phoneNum;
        user.fullName = fullname;
        NSError *error;
        if (![moc save:&error]) {
            NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        } else {
            if (completion) {
                completion (YES);
            }
        }
    }];
}

+ (void)getUserDetailsWithMoc:(NSManagedObjectContext*)moc
               withCompletion:(void (^)(AISUserDetails *userDetails))completion {
    
    [moc performBlock:^{
        NSFetchRequest *fetchRequest = [AISUserDetails fetchRequest];
        NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
        if (results && results.count > 0) {
            if (completion) {
                completion(results.firstObject);
            }
        }
    }];
}

+ (void)deleteUserDetailsWithMoc:(NSManagedObjectContext*)moc
                  withCompletion:(void (^)(BOOL success))completion {
    [moc performBlock:^{
        NSFetchRequest *fetchRequest = [AISUserDetails fetchRequest];
        NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
        
        for (NSManagedObject *result in results) {
            [moc deleteObject:result];
        }
        NSError *saveError = nil;
        [moc save:&saveError];
    }];
}

@end
