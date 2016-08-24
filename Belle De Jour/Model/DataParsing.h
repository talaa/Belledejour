//
//  DataParsing.h
//  Belle De Jour
//
//  Created by Mina on 8/22/16.
//  Copyright © 2016 SpringMoon. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@interface DataParsing : NSObject

//user's Name
@property(nonatomic,strong)NSString * name;
//user's Email
@property(nonatomic,strong)NSString * emailAddress;
//user's MobileNumber
@property(nonatomic,strong)NSString * mobileNumber;
//user's Password
@property(nonatomic,strong)NSString * password;
//user's LoyaltyPoints
@property(nonatomic,assign)NSInteger loyaltyPoints;
//user's profile imageData
@property(nonatomic,strong)NSData *imageData;
//user's ProfilePhotoURL
@property(nonatomic,strong)NSString *profilePhotoURL;
//Firebase DB refrence
@property (nonatomic , retain) FIRDatabaseReference *referenceFirebaseDatabase;
//firebase Storage
@property (nonatomic , retain) FIRStorage *firebaseStorage;
//firebase Stroage Refrence
@property (nonatomic , retain) FIRStorageReference * referenceFirebaseStorage;

//singltone instance
+ (DataParsing*)getInstance;
//save retrieved user data in NSUserDefault Object
+ (void)setDataParsingCurrentUserObject:(FIRDataSnapshot *)userData ImageData:(NSData *)data;
//get name
+(NSString*)getUserName;
//get phone
+(NSString*)getUserPhone;
//get email
+(NSString*)getUseremail;
//get imageData
+(NSData*)getImageData;
//get ProfileURL
+(NSString*)getUserProfileURL;
@end
