//
//  NSData+Dictionary.m
//  AirAsia
//
//  Created by ATS on 3/26/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "NSData+Dictionary.h"

@implementation NSData (Dictionary)
- (NSDictionary *)aa_Dictionary {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:nil];
    return dict;
}
@end
