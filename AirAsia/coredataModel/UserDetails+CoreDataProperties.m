//
//  UserDetails+CoreDataProperties.m
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import "UserDetails+CoreDataProperties.h"

@implementation UserDetails (CoreDataProperties)

+ (NSFetchRequest<UserDetails *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserDetails"];
}

@dynamic email;
@dynamic phoneNumber;
@dynamic username;

@end
