//
//  NetworkRequester.m
//  Belle De Jour
//
//  Created by Mina on 8/22/16.
//  Copyright © 2016 SpringMoon. All rights reserved.
//

#import "NetworkRequester.h"

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

@end
