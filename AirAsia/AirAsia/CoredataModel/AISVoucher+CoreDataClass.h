//
//  AISVoucher+CoreDataClass.h
//  AirAsia
//
//  Created by Vijay on 27/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AISVoucher : NSManagedObject

+ (void)insertOrUpdateVoucherWithID:(NSString *)voucherID
                           withInfo:(NSDictionary *)info
                                moc:(NSManagedObjectContext*)moc
                       withCompletion:(void (^)(AISVoucher *voucher))completion;

@end

NS_ASSUME_NONNULL_END

#import "AISVoucher+CoreDataProperties.h"
