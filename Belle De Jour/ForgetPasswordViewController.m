//
//  ForgetPasswordViewController.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/13/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SVProgressHUD.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "SMBInternetConnectionIndicator.h"

@implementation ForgetPasswordViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    ShowInternetIndicator;
}
- (void)setScreenState:(BOOL)state{
    (!state)?[SVProgressHUD show]:[SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:state];
    UIBarButtonItem *leftbutton = self.navigationItem.leftBarButtonItem;
    leftbutton.enabled = state;
}
- (IBAction)sendPressed:(id)sender {
    [self setScreenState:NO];
    [PFUser requestPasswordResetForEmailInBackground:_emailAddresTxt.text];
    [self setScreenState:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Done" message:@"Please Review Your Email To Change The Password " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
