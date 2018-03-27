//
//  AISUserDetails+CoreDataProperties.h
//  AirAsia
//
//  Created by ATS on 3/23/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import "AISUserDetails+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AISUserDetails (CoreDataProperties)

+ (NSFetchRequest<AISUserDetails *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *avatar;
@property (nullable, nonatomic, copy) NSString *fullName;

@end

extern NSString* const _Nonnull  kUserName;
extern NSString* const _Nonnull  kUserEmail;
extern NSString* const _Nonnull  kUserFullname;
extern NSString* const _Nonnull  kUserPhoneNum;
extern NSString* const _Nonnull  kUserAvatar;

NS_ASSUME_NONNULL_END
