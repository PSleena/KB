//
//  AISUserDetails+CoreDataProperties.m
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import "AISUserDetails+CoreDataProperties.h"

@implementation AISUserDetails (CoreDataProperties)

+ (NSFetchRequest<AISUserDetails *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AISUserDetails"];
}

@dynamic email;
@dynamic phoneNumber;
@dynamic username;
@dynamic avatar;
@dynamic fullName;

@end

NSString* const _Nonnull  kUserName = @"userName";
NSString* const _Nonnull  kUserEmail = @"email";
NSString* const _Nonnull  kUserFullname = @"fullName";
NSString* const _Nonnull  kUserPhoneNum = @"phoneNum";
NSString* const _Nonnull  kUserAvatar = @"avatar";
