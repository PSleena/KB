//
//  AISContactUtility.h
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AISContactUtility : NSObject
+ (void)getAllMyContactsWithCompletion:(void (^) (NSArray *contactList))completion;
@end
