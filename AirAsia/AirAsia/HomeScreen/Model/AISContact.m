//
//  AISContact.m
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISContact.h"

@implementation AISContact
- (instancetype)initWithInfo:(NSDictionary *)dic {
    
    self = [super init];
    
    if (self) {
        self.userImage = dic[@"userImage"];
        self.fullName = dic[@"fullName"];
        self.phone = dic[@"PhoneNumbers"];
        self.email = dic[@"userEmailId"];
    }
    return self;
}
@end
