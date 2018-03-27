//
//  AISContactUtility.m
//  AirAsia
//
//  Created by ATS on 3/27/18.
//  Copyright © 2018 AirAsia. All rights reserved.
//

#import "AISContactUtility.h"
#import <Contacts/Contacts.h>
#import "AISContact.h"

@implementation AISContactUtility

+ (void)getAllMyContactsWithCompletion:(void (^) (NSArray *contactList))completion{
    //ios 9+
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
            //keys with fetching properties
            NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey, CNContactEmailAddressesKey];
            NSString *containerId = store.defaultContainerIdentifier;
            NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
            NSError *error;
            NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
            if (error) {
                NSLog(@"error fetching contacts %@", error);
                completion (@[]);
            } else {
                NSString *phone;
                NSString *fullName;
                NSString *firstName;
                NSString *lastName;
                UIImage *profileImage;
                NSMutableArray *contactNumbersArray;
                NSMutableArray *emailArray;
                NSString* email = @"";
                NSMutableArray *contactsArray = [[NSMutableArray alloc] init];
                for (CNContact *contact in cnContacts) {
                    // copy data to my custom Contacts class.
                    firstName = contact.givenName;
                    lastName = contact.familyName;
                    if (lastName == nil) {
                        fullName=[NSString stringWithFormat:@"%@",firstName];
                    }else if (firstName == nil){
                        fullName=[NSString stringWithFormat:@"%@",lastName];
                    }
                    else{
                        fullName=[NSString stringWithFormat:@"%@ %@",firstName,lastName];
                    }
                    UIImage *image = [UIImage imageWithData:contact.imageData];
                    if (image != nil) {
                        profileImage = image;
                    }else{
                        profileImage = [UIImage imageNamed:@"placeholder.png"];
                    }
                    for (CNLabeledValue *label in contact.phoneNumbers) {
                        phone = [label.value stringValue];
                        if ([phone length] > 0) {
                            [contactNumbersArray addObject:phone];
                        }
                    }
                    ////Get all E-Mail addresses from contacts
                    for (CNLabeledValue *label in contact.emailAddresses) {
                        email = label.value;
                        if ([email length] > 0) {
                            [emailArray addObject:email];
                        }
                    }
                    //NSLog(@"EMAIL: %@",email);
                    AISContact *contact = [[AISContact alloc] init];
                    contact.fullName = fullName;
                    contact.userImage = profileImage;
                    contact.phone = phone;
                    contact.email = email;
                    
//                    NSDictionary* personDict = [[NSDictionary alloc] initWithObjectsAndKeys: fullName,@"fullName",profileImage,@"userImage",phone,@"PhoneNumbers",email,@"userEmailId", nil];
                    // NSLog(@"Response: %@",personDict);
                    [contactsArray addObject:contact];
                }
                completion([contactsArray copy]);
            }
        } else {
            completion(@[]);
        }
    }];
}

@end
