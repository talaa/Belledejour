//
//  Service.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/1/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface Service : NSObject
@property(nonatomic,assign)int serviceID;
@property(nonatomic,strong)NSString * serviceType;
@property(nonatomic,strong)NSString * serviceDescription;
@property(nonatomic,assign)int servicePrice;
@property(nonatomic,assign)double serviceLoyaltyPoints;
@property(nonatomic,strong)PFFile  * serviceImage;


@end
