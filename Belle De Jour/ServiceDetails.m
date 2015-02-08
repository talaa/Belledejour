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
    
    [_recommendbutton.layer setCornerRadius:5.0];
    [_recommendbutton.layer setMasksToBounds:YES];
    
    self.serviceImage.contentMode = UIViewContentModeScaleAspectFit;

    [self setBorder:_bookBtn];
    [self setBorder:_serviceImage];
    [self setBorder:self.basketImg];
    self.basketImg.contentMode = UIViewContentModeScaleAspectFit;
    if(_service!=nil)
    {
    [self.navigationItem setTitle:_navigationTitle];
    [self.servicePrice setText:[NSString stringWithFormat:@"%i AED", _service.servicePrice]];
    [self.serviceDescriptionTxt setText:_service.serviceDescription];
        [self.loyaltyPointsLbl setText:[NSString stringWithFormat:@"You have %0.2f Points",_service.serviceLoyaltyPoints]];
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
        [self.servicePrice setText:[NSString stringWithFormat:@"%i AED", _offer.offerPrice]];
        [self.serviceDescriptionTxt setText:_offer.offerDescription];
        [self.loyaltyPointsLbl setText:[NSString stringWithFormat:@"You have %0.2d Points",_offer.loyaltyPoints]];
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
-(void)setBorder:(UIView*)view
{
    // border radius
    [view.layer setCornerRadius:10.0f];
    [view.layer setMasksToBounds:YES];
    
    // border
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:1.5f];
    
    // drop shadow
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.8];
    [view.layer setShadowRadius:3.0];
    [view.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
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
            bookingView.serviceImage=_serviceImage.image;

        }

            
        }
}
-(IBAction)Share:(id)sender{
    NSString *recommendme=[[NSString alloc]initWithFormat:@"HI , I do Recommend this %@ service from BELLE DE JOUR MEDICAL SPA  \nWebsite:www.belledejour.ae \nPhone:043475336",_navigationTitle];
    NSArray *sharedArray=[[NSArray alloc]initWithObjects:_serviceImage.image,recommendme, nil];
    UIActivityViewController *activityViewController2 =[[UIActivityViewController alloc]initWithActivityItems:sharedArray applicationActivities:nil];

[self presentViewController:activityViewController2 animated:YES completion:^{}];




}
@end
