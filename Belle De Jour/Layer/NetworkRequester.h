//
//  NetworkRequester.h
//  Belle De Jour
//
//  Created by Mina on 8/22/16.
//  Copyright © 2016 SpringMoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
@import Firebase;

@interface NetworkRequester : NSObject

//Create An User auth row then Add a User Data row on Users table
+ (void)createFireBaseUserAccount:(NSString*)email Password:(NSString*)password completionBlock:(void (^) (NSError *error, FIRUser *user))completion;

//sign In
+ (void)signInFirebaseByMail:(NSString*)mail Password:(NSString*)password Completion:(void (^)(NSError *error, FIRUser *user))compeletion;

//log out
+ (void)logOutUser:(void (^)(NSError *error))completion;

//Send a password reset email
+ (void)sendPasswordResetEmail:(NSString*)email Completion:(void (^) (NSError *error))completion;

//Upload from NSData on memory -> Storage
+ (void)uploadfilePathName:(NSString *)name Data:(NSData *)data Completion:(void (^) (FIRStorageMetadata *metadata,NSError *error))completion;

//Add UserData on Users table
+ (void)addUserDataFireBaseDBb:(NSDictionary *)parm User:(FIRUser*)user;

@end
