//
//  Stuff.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/13/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface Stuff : NSObject
@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)PFFile * _image;
@end
