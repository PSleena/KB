//
//  AISVoucherModel.h
//  AirAsia
//
//  Created by ATS on 3/28/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AISVoucherModel : NSObject
- (instancetype)initWithInfo:(NSDictionary *)dic;

@property (nonatomic,strong) NSString *voucherID;
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *qrCodePath;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *createdDate;
@property (nonatomic,strong) NSString *expiryInterval;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *imageURL;

//no time as of now
//@property (nonatomic,strong) AISTransation *transactionObj;
@end
