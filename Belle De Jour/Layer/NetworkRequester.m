//
//  NetworkRequester.m
//  Belle De Jour
//
//  Created by Mina on 8/22/16.
//  Copyright © 2016 SpringMoon. All rights reserved.
//

#import "NetworkRequester.h"
#import "DataParsing.h"
#import "SVProgressHUD.h"
#import "AppConstants.h"

@implementation NetworkRequester

//Create a User Auth
+ (void)createFireBaseUserAccount:(NSString*)email Password:(NSString*)password completionBlock:(void (^) (NSError *error, FIRUser *user))completion {
    [[FIRAuth auth] createUserWithEmail:email password:password completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
        // ...
        if (user && !error){
            completion(nil, user);
        }else{
            completion(error, nil);
        }
        
    }];
}

//sign In
+ (void)signInFirebaseByMail:(NSString*)mail Password:(NSString*)password Completion:(void (^)(NSError *error, FIRUser *user))compeletion{
    [[FIRAuth auth] signInWithEmail:mail
                           password:password
                         completion:^(FIRUser *user, NSError *error) {
                             // ...
                             if (!error && user){
                                 //done signIn Successfully
                                 compeletion(nil, user);
                             }else{
                                 //error
                                 compeletion(error, nil);
                             }
                         }];
}

//log out
+ (void)logOutUser:(void (^)(NSError *error))completion {
    NSError *error;
    [[FIRAuth auth] signOut:&error];
    if (!error) {
        // Sign-out succeeded
        completion(nil);
    }else{
        completion(error);
    }
}

//Send a password reset email
+ (void)sendPasswordResetEmail:(NSString*)email Completion:(void (^) (NSError *error))completion {
    [[FIRAuth auth] sendPasswordResetWithEmail:email completion:^(NSError *_Nullable error) {
        if (error) {
            // An error happened.
            completion(error);
        } else {
            // Password reset email sent.
            completion(nil);
        }
    }];
}

//Upload from NSData on memory -> Storage
+ (void)uploadfilePathName:(NSString *)name Data:(NSData *)data Completion:(void (^) (FIRStorageMetadata *metadata,NSError *error))completion {
    
    // Create a reference to the file you want to upload
    FIRStorageReference *riversRef = [[DataParsing getInstance].referenceFirebaseStorage child:name];
    
    // Upload the file to the path for example-> "images/rivers.jpg"
    FIRStorageUploadTask *uploadTask = [riversRef putData:data metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
        if (error != nil) {
            // Uh-oh, an error occurred!
            completion(nil, error);
        } else {
            // Metadata contains file metadata such as size, content-type, and download URL.
            completion(metadata, nil);
        }
    }];
    
    [uploadTask observeStatus:FIRStorageTaskStatusProgress handler:^(FIRStorageTaskSnapshot *snapshot) {
        // Upload reported progress
        double percentComplete = 100.0 * (snapshot.progress.completedUnitCount) / (snapshot.progress.totalUnitCount);
        [SVProgressHUD showProgress:percentComplete/100 status:[NSString stringWithFormat:@"%.0f%%",percentComplete]];
    }];
}

@end
