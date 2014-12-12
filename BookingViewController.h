//
//  BookingViewController.h
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/19/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingViewController : UIViewController
@property(nonatomic,strong)NSString * serviceName;
@property(nonatomic,assign)int servicePrice;
@property(nonatomic,strong)UIImage * serviceImage;
@property (weak, nonatomic) IBOutlet UIImageView *serviceImgView;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLbl;
@property (weak, nonatomic) IBOutlet UITextField *reservationDateTxt;
- (IBAction)confirmBooking:(id)sender;
- (IBAction)reserveDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;
- (IBAction)doneToolBarPressed:(id)sender;
- (IBAction)cancelToolBarPressed:(id)sender;

@end
