//
//  AISVoucher+CoreDataClass.m
//  AirAsia
//
//  Created by Vijay on 27/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//
//

#import "AISVoucher+CoreDataClass.h"

@implementation AISVoucher

+ (void)insertOrUpdateVoucherWithID:(NSString *)voucherID
                           withInfo:(NSDictionary *)info
                                moc:(NSManagedObjectContext*)moc
                     withCompletion:(void (^)(AISVoucher *voucher))completion {
    
    [moc performBlock:^{
        AISVoucher *voucher = nil;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"voucherID == %@", voucherID];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"AISVoucher"];
        [fetchRequest setPredicate:predicate];
        NSArray *result =  [moc executeFetchRequest:fetchRequest error:nil];
        voucher = [result firstObject];
        if (!voucher) {
            voucher = [NSEntityDescription insertNewObjectForEntityForName:@"AISVoucher" inManagedObjectContext:moc];
        }
        voucher.name = info[@"name"] ?: @"";
        voucher.phone = info[@"phone"] ?: @"";
        voucher.email = info[@"email"] ?: @"";
        voucher.voucherID = info[@"voucherID"];
        voucher.createdDate = info[@"createdDate"] ?: @"";
        voucher.expiryInterval = info[@"expiryInterval"] ?: @"";
        voucher.qrCodePath = info[@"qrCodePath"] ?: @"";
        voucher.category = info[@"category"] ?: @"";
        voucher.type = info[@"type"] ?: @"";
        voucher.price = info[@"price"] ?: @"";
        voucher.message = info[@"message"] ?: @"";
        voucher.imageURL = info[@"imageURL"] ?: @"";
        NSError *error;
        if (![moc save:&error]) {
            NSLog(@"Failed to save - error: %@", [error localizedDescription]);
            if (completion) {
                completion(nil);
            }
        } else {
            if (completion) {
                completion(voucher);
            }
        }
    }];
}

+ (void)deleteVoucherWithID:(NSString *)voucherID
                        moc:(NSManagedObjectContext*)moc
             withCompletion:(void (^)(BOOL success))completion {
    [moc performBlock:^{
        AISVoucher *voucher = nil;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"voucherID == %@", voucherID];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"AISVoucher"];
        [fetchRequest setPredicate:predicate];
        NSArray *result =  [moc executeFetchRequest:fetchRequest error:nil];
        voucher = [result firstObject];
        if(voucher) {
            [moc deleteObject:voucher];
            NSError *error;
            if (![moc save:&error]) {
                NSLog(@"Failed to save - error: %@", [error localizedDescription]);
                if (completion) {
                    completion(NO);
                }
            } else {
                if (completion) {
                    completion(YES);
                }
            }
        }
    }];
}

@end
