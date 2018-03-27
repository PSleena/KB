//
//  AISFilePathUtility.m
//  AirAsia
//
//  Created by Vijay on 27/03/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISFilePathUtility.h"

@implementation AISFilePathUtility

+ (NSString *)newQRCodePath {
    NSString *filePath = [[self applicationDocumentsDirectory] path];
    NSUUID *UUID = [NSUUID UUID];
    NSString* stringUUID = [UUID UUIDString];
   filePath =  [filePath stringByAppendingPathComponent:@"BarCode"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    filePath = [filePath stringByAppendingPathComponent:stringUUID];
    filePath = [filePath stringByAppendingPathExtension:@"jpg"];
    return filePath;
}

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
