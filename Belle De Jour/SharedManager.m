//
//  SharedManager.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/12/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "SharedManager.h"
#import "User.h"
@implementation SharedManager
static User* _userProfile = nil;
static bool _isBooked;
static bool _isFacebook;
static  SharedManager*sharedMyManager = nil;

#pragma mark shared singleton
-(User*)userProfile
{
    if(_userProfile == nil)
    {
        _userProfile = [[User alloc]init];
    }
    
    return _userProfile;
}
-(void)setUserProfile:(User*)user
{
    _userProfile = user;
}
-(void)isBooking:(BOOL)isbooked
{
    _isBooked=isbooked;
}
-(BOOL)isbooked
{
    return _isBooked;
}

-(void)isFacebookLogin:(BOOL)isFacebook
{
    _isFacebook=isFacebook;
}
-(BOOL)isFacebook
{
    return _isFacebook;
}
+ (SharedManager*)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
@end
