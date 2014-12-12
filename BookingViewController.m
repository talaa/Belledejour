//
//  BookingViewController.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/19/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "BookingViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SharedManager.h"
#import <Parse/Parse.h>

@interface BookingViewController ()
{
    NSString * reservationDate;
}

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.serviceNameLbl.text=self.serviceName;
    self.servicePriceLbl.text=[NSString stringWithFormat:@"%i",self.servicePrice];
    [self.serviceImgView setImage: self.serviceImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmBooking:(id)sender {
    if([[SharedManager sharedManager]userProfile].userName==nil)
    {
    [[SharedManager sharedManager]isBooking:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:ivc animated:YES completion:nil];
    }
    if(reservationDate!=nil&&[[SharedManager sharedManager]userProfile].name!=nil)
    {
            PFObject *bookingData = [PFObject objectWithClassName:@"Booking"];
            [bookingData setObject:[[SharedManager sharedManager]userProfile].name forKey:@"Name"];
            [bookingData setObject:[[SharedManager sharedManager]userProfile].userName forKey:@"User_Name"];
            [bookingData setObject:[NSString stringWithFormat:@"%i",[[SharedManager sharedManager]userProfile].mobileNumber]  forKey:@"User_Mobile_Number"];
            [bookingData setObject:self.serviceName forKey:@"Service_Name"];
            [bookingData setValue:[NSNumber numberWithInt: self.servicePrice ] forKey:@"Service_Price"];
            [bookingData setObject:reservationDate forKey:@"Reservation_Date"];
            [bookingData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
                        if (!error) {
                            // Show success message
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully Operation" message:@"Thanks for choosing us " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                        } else {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internal Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
            
                        }
            
                    }];

    }
    else if((reservationDate=nil))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Please enter reservation date to complete booking process !!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }
    
    
}

- (IBAction)reserveDate:(id)sender {
    self.datePickerView.hidden=NO;
}
- (IBAction)doneToolBarPressed:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    NSDate *selectedDate = [self.datePicker date];
    reservationDate = [dateFormatter stringFromDate:selectedDate];
    self.datePickerView.hidden=YES;

}

- (IBAction)cancelToolBarPressed:(id)sender {
    self.datePickerView.hidden=YES;

}
@end
