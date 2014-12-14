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
#import "Constants.h"
#import "SVProgressHUD.h"

@interface BookingViewController ()
{
    NSString * reservationDate;
}

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ShowInternetIndicator;
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
- (void)setScreenState:(BOOL)state{
    (!state)?[SVProgressHUD show]:[SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:state];
    UIBarButtonItem *leftbutton = self.navigationItem.leftBarButtonItem;
    leftbutton.enabled = state;
}
- (IBAction)confirmBooking:(id)sender {
    if([[SharedManager sharedManager]userProfile].userName==nil)
    {
    [[SharedManager sharedManager]isBooking:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:ivc animated:YES completion:nil];
    }
   else if(reservationDate!=nil&&[[SharedManager sharedManager]userProfile].name!=nil)
    {
        [self setScreenState:NO];
            PFObject *bookingData = [PFObject objectWithClassName:@"Booking"];
            [bookingData setObject:[[SharedManager sharedManager]userProfile].name forKey:@"Name"];
            [bookingData setObject:[[SharedManager sharedManager]userProfile].userName forKey:@"User_Name"];
            [bookingData setObject:[NSString stringWithFormat:@"%li",(long)[[SharedManager sharedManager]userProfile].mobileNumber]  forKey:@"User_Mobile_Number"];
            [bookingData setObject:self.serviceName forKey:@"Service_Name"];
            [bookingData setValue:[NSNumber numberWithInt: self.servicePrice ] forKey:@"Service_Price"];
            [bookingData setObject:reservationDate forKey:@"Reservation_Date"];
            [bookingData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
                        if (!error) {
                            // Show success message
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully Operation" message:@"Thanks for choosing us " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            [self showEmail];
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
    
    [self setScreenState:YES];

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
- (void)showEmail {
    
    NSString *emailTitle = @"Belle De Jour Testing Email !!";
    NSString *messageBody = [NSString stringWithFormat:@"%@ \n %@ \n %@  ",_serviceName,reservationDate,[[SharedManager sharedManager]userProfile].name ];
   // NSArray *toRecipents = [NSArray arrayWithObject:@"mahmoud_elbishbishy@hotmail.com"];
    NSArray *toRecipents = [NSArray arrayWithObject:@"nadagamal_ng@yahoo.com"];
 
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Determine the file name and extension
//    NSArray *filepart = [file componentsSeparatedByString:@"."];
//    NSString *filename = [filepart objectAtIndex:0];
//    NSString *extension = [filepart objectAtIndex:1];
//    
//    // Get the resource path and read the file using NSData
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
//    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
//    
//    // Determine the MIME type
//    NSString *mimeType;
//    if ([extension isEqualToString:@"jpg"]) {
//        mimeType = @"image/jpeg";
//    } else if ([extension isEqualToString:@"png"]) {
//        mimeType = @"image/png";
//    } else if ([extension isEqualToString:@"doc"]) {
//        mimeType = @"application/msword";
//    } else if ([extension isEqualToString:@"ppt"]) {
//        mimeType = @"application/vnd.ms-powerpoint";
//    } else if ([extension isEqualToString:@"html"]) {
//        mimeType = @"text/html";
//    } else if ([extension isEqualToString:@"pdf"]) {
//        mimeType = @"application/pdf";
//    }
    //NSString * mimeType = @"image/jpeg";

    //CGDataProviderRef provider = CGImageGetDataProvider(_serviceImage.CGImage);
   // NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    // Add attachment
   // [mc addAttachmentData:data mimeType:mimeType fileName:filename];
    
    // Present mail view controller on screen
    [self dismissViewControllerAnimated:YES completion:NULL];

    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
