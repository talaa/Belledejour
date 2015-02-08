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
    self.servicePriceLbl.text=[NSString stringWithFormat:@"%i AED",self.servicePrice];
    [self.servicePriceLbl.layer setCornerRadius:10.0f];
    [self.servicePriceLbl.layer setMasksToBounds:YES];
    self.servicePriceLbl.backgroundColor=[UIColor colorWithRed:0.51559f green:0.8254f blue:0.381f alpha:0.8631];
    self.servicePriceLbl.textColor=[UIColor whiteColor];
    [self.serviceImgView setImage: self.serviceImage];
    
    [self setBorder:_serviceImgView];

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
    self.datePicker.minimumDate=[NSDate date];
}
- (IBAction)doneToolBarPressed:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *selectedDate = [self.datePicker date];
    reservationDate = [dateFormatter stringFromDate:selectedDate];
    self.datePickerView.hidden=YES;
    [_reserveDateBtn setTitle:[NSString stringWithFormat:@"Reservation Date is %@", reservationDate ]forState:UIControlStateNormal];
    _backfinal.hidden=NO;
    _Finalreservationlabel.hidden=NO;
    [_Finalreservationlabel setText:[NSString stringWithFormat:@"Reservation Date is %@", reservationDate ]];

}

- (IBAction)cancelToolBarPressed:(id)sender {
    self.datePickerView.hidden=YES;

}
- (void)showEmail {
    
    NSString *emailTitle = @"Belle De Jour Booking Email !!";
    NSString *messageBody = [NSString stringWithFormat:@"I would like to book %@ \n %@ \n %@ \nWaiting for your confirmation ",_serviceName,reservationDate,[[SharedManager sharedManager]userProfile].name ];
   // NSArray *toRecipents = [NSArray arrayWithObject:@"mahmoud_elbishbishy@hotmail.com"];
    NSArray *toRecipents = [NSArray arrayWithObject:@"info@belledejour.ae"];
 
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
