//
//  ServiceDetails.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/11/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "ServiceDetails.h"
#import "BookingViewController.h"

@implementation ServiceDetails
-(void)viewDidLoad
{
    if(_service!=nil)
    {
    [self.navigationItem setTitle:_navigationTitle];
    [self.servicePrice setText:[NSString stringWithFormat:@"%i Dirham", _service.servicePrice]];
    [self.serviceDescriptionTxt setText:_service.serviceDescription];
        [self.loyaltyPointsLbl setText:[NSString stringWithFormat:@"You have %f Points",_service.serviceLoyaltyPoints]];
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
        [self.loyaltyPointsLbl setText:[NSString stringWithFormat:@"You have %d Points",_offer.loyaltyPoints]];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BookingViewController * bookingView=(BookingViewController*)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"Booking"]) {
        if(_service !=nil)
        {
            bookingView.serviceName = _service.serviceType;
            bookingView.servicePrice= _service.servicePrice;
            bookingView.serviceImage=_serviceImage.image;
        }
        else if (_offer!=nil)
        {
            bookingView.serviceName=_offer.offerName;
            bookingView.servicePrice=_offer.offerPrice;
            bookingView.serviceImage=self.serviceImage.image;
        }

            
        }
}

@end
