//
//  AppDelegate.m
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AppDelegate.h"
#import "AISCoreDataManager.h"
#import "AISConstants.h"
#import "AISLoginViewController.h"
#import "AISUIUtility.h"
#import "AISVoucher+CoreDataClass.h"
#import "AISUserManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    BOOL login = [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultuserLogin];
    if (!login) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AISLoginViewController *con = [storyboard instantiateViewControllerWithIdentifier:@"AISLoginViewController"];
        [self.window setRootViewController:con];
    } else {
        [self fetchConfig];
    }
    
    return YES;
}

- (void)fetchConfig {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *dic = [AISUIUtility dataFromJsonFileWithName:@"Config"];
        NSArray *arr = dic[@"voucherDetails"];
        for (NSDictionary *voucher in arr) {
          [AISVoucher insertOrUpdateVoucherWithID:voucher[@"voucherID"]
                                         withInfo:voucher
                                              moc:[AISCoreDataManager sharedManager].managedObjectContext
                                   withCompletion:^(AISVoucher * _Nonnull voucher) {
                                       [[[AISUserManager sharedInstance] myVouchers] addObject:voucher];
                                       if (arr.count == [[AISUserManager sharedInstance] myVouchers].count) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [[NSNotificationCenter defaultCenter] postNotificationName:@"ConfigComplete" object:nil];
                                           });
                                       }
                                   }];
        }
    });
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[AISCoreDataManager sharedManager] saveContext];
}


@end
