//
//  AISVoucherModel.m
//  AirAsia
//
//  Created by ATS on 3/28/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISVoucherModel.h"

@implementation AISVoucherModel
- (instancetype)initWithInfo:(NSDictionary *)dic {
    self = [super init];
    
    if (self) {
        self.voucherID = dic[@"voucherID"] ?: @"";
        self.category = dic[@"category"] ?: @"";
        self.qrCodePath = dic[@"qrCodePath"] ?: @"";
        self.type = dic[@"type"] ?: @"";
        self.name = dic[@"name"] ?: @"";
        self.phone = dic[@"phone"] ?: @"";
        self.email = dic[@"email"] ?: @"";
        self.createdDate = dic[@"createdDate"] ?: @"";
        self.expiryInterval = dic[@"expiryInterval"] ?: @"";
        self.price = dic[@"price"] ?: @"";
        self.message = dic[@"message"] ?: @"";
        self.imageURL = dic[@"imageURL"] ?: @"";
    }
    return self;
}
@end
