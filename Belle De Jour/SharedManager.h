//
//  SharedManager.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/12/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface SharedManager : NSObject
-(User*)userProfile;
-(void)setUserProfile:(User*)user;
+ (SharedManager*)sharedManager;
-(void)isBooking:(BOOL)isbooked;
-(BOOL)isbooked;

@end
