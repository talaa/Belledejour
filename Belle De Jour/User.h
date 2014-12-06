//
//  User.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/6/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * userName;
@property(nonatomic,strong)NSString * emailAddress;
@property(nonatomic,assign)NSInteger  mobileNumber;
@property(nonatomic,strong)NSString * password;
@end
