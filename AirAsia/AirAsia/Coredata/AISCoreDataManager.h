//
//  AISCoreDataManager.h
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AISUserDetails+CoreDataClass.h"

@interface AISCoreDataManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (AISCoreDataManager *)sharedManager;

- (void)saveContext;

- (void)saveUserInfo:(NSDictionary *)info withCompletion:(void (^)(BOOL success))completion;

@end
