//
//  Offer.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/11/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface Offer : NSObject
@property (nonatomic,strong)NSString * offerName;
@property(nonatomic,strong)PFFile  * offerImage;
@property(nonatomic,strong)NSString * offerDescription;
@property(nonatomic,assign)int offerPrice;
@property(nonatomic,assign)int loyaltyPoints;
@end
