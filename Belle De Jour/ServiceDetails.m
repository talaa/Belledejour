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
    if(_service!=nil)
    {
    [self.navigationItem setTitle:_navigationTitle];
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
    else if(_offer != nil)
    {
        [self.navigationItem setTitle:_navigationTitle];
        [self.servicePrice setText:[NSString stringWithFormat:@"%i Dirham", _offer.offerPrice]];
        [self.serviceDescriptionTxt setText:_offer.offerDescription];
        __block UIImage *MyPicture = [[UIImage alloc]init];
        PFFile *imageFile = _offer.offerImage;
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
            if (!error) {
                MyPicture = [UIImage imageWithData:data];
                self.serviceImage.image = MyPicture;
            }
        }];;
    }
    
}

@end
