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
@property (nullable, nonatomic, copy) NSString *message;
@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
