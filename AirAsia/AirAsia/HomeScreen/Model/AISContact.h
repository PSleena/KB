//
//  AISContact.h
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AISContact : NSObject

- (instancetype)initWithInfo:(NSDictionary *)dic;

@property (nonatomic,strong) NSString *fullName;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *message;

@end

