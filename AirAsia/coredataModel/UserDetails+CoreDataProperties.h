//
//  UserDetails+CoreDataProperties.h
//  AirAsia
//
//  Created by Vijay on 10/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import "UserDetails+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserDetails (CoreDataProperties)

+ (NSFetchRequest<UserDetails *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSString *username;

@end

NS_ASSUME_NONNULL_END
