//
//  UserDetails+CoreDataClass.m
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import "UserDetails+CoreDataClass.h"
#import "AppDelegate.h"

@implementation UserDetails
+ (void)insertUserDetailsWithUserName:(NSString *)username
                              emailId:(NSString *)email
                             phoneNum:(NSString *)phoneNum
                       withCompletion:(void (^)(BOOL success))completion {
    
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = del.persistentContainer.viewContext;
    [moc performBlock:^{
        UserDetails *user = [NSEntityDescription insertNewObjectForEntityForName:@"UserDetails" inManagedObjectContext:moc];
        user.username = username;
        user.email = email;
        user.phoneNumber = phoneNum;
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

+ (void)getUserDetailsWithCompletion:(void (^)(UserDetails *userDetails))completion {
    
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = del.persistentContainer.viewContext;
    [moc performBlock:^{
        NSFetchRequest *fetchRequest = [UserDetails fetchRequest];
        NSArray *results = [moc executeFetchRequest:fetchRequest error:nil];
        if (results && results.count > 0) {
            if (completion) {
                completion(results.firstObject);
            }
        }
    }];
}

@end
