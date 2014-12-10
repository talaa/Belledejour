//
//  ServiceDetails.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/11/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "ServiceDetails.h"

@implementation ServiceDetails
-(void)viewDidLoad
{
    [self.navigationItem setTitle: _service.serviceType];
    [self.servicePrice setText:[NSString stringWithFormat:@"%i Dirham", _service.servicePrice]];
    [self.serviceDescriptionTxt setText:_service.serviceDescription];
    __block UIImage *MyPicture = [[UIImage alloc]init];
    PFFile *imageFile = _service.serviceImage;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        if (!error) {
            MyPicture = [UIImage imageWithData:data];
            self.serviceImage.image = MyPicture;
        }
    }];;
    
}

@end
