//
//  AISVoucher+CoreDataProperties.h
//  AirAsia
//
//  Created by Vijay on 27/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import "AISVoucher+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AISVoucher (CoreDataProperties)

+ (NSFetchRequest<AISVoucher *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *voucherID;
@property (nullable, nonatomic, copy) NSString *qrCodePath;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *createdDate;
@property (nullable, nonatomic, copy) NSString *expiryInterval;

@end

NS_ASSUME_NONNULL_END
