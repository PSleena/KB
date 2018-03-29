//
//  AISVoucher+CoreDataProperties.m
//  AirAsia
//
//  Created by Vijay on 27/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import "AISVoucher+CoreDataProperties.h"

@implementation AISVoucher (CoreDataProperties)

+ (NSFetchRequest<AISVoucher *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AISVoucher"];
}

@dynamic voucherID;
@dynamic qrCodePath;
@dynamic name;
@dynamic phone;
@dynamic email;
@dynamic createdDate;
@dynamic expiryInterval;
@dynamic message;
@dynamic price;
@dynamic category;
@dynamic type;
@dynamic imageURL;
@end
