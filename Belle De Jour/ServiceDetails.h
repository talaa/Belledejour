//
//  ServiceDetails.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/11/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
@interface ServiceDetails : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *serviceImage;
@property (weak, nonatomic) IBOutlet UILabel *servicePrice;
@property (weak, nonatomic) IBOutlet UITextView *serviceDescriptionTxt;
@property (nonatomic,strong) NSString * navigationTitle;
@property (nonatomic,strong) Service * service;

@end