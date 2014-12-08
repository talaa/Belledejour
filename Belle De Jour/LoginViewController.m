//
//  LoginViewController.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/4/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"
#import "LeftViewController.h"
#import "AppDelegate.h"
#import "UIViewController+RESideMenu.h"
#import "Constants.h"
#import "SMBInternetConnectionIndicator.h"

@interface LoginViewController ()
{
    UIAlertController * alertController;
    UIAlertAction * okAction;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowInternetIndicator;
     okAction = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction *action)
                                {
                                    NSLog(@"OK action");
                                }];
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
#pragma mark - UITextField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+100);
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-100);
    
}-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)signIn:(id)sender {
  
    [self setScreenState:NO];
    if(_usernameTxt.text.length>0 && _passwordTxt.text.length>0)
    {
    [PFUser logInWithUsernameInBackground:_usernameTxt.text password:_passwordTxt.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                        
                                            alertController = [UIAlertController
                                                               alertControllerWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"%@ %@ ",@"Welcome",_usernameTxt.text]
                                                               preferredStyle:UIAlertControllerStyleAlert];
                                            [alertController addAction:okAction];
                                            [self presentViewController:alertController animated:YES completion:nil];

                                        } else {
                                            alertController = [UIAlertController
                                                               alertControllerWithTitle:@"Alert"
                                                               message:[NSString stringWithFormat:@"%@ ",@"Please enter valid Credentials,"]
                                                               preferredStyle:UIAlertControllerStyleAlert];
                                            [alertController addAction:okAction];
                                            [self presentViewController:alertController animated:YES completion:nil];                                        }
                                    }];
    }
    else
    {
        alertController = [UIAlertController
                           alertControllerWithTitle:@"Alert"
                           message:@"Please enter fields!!"
                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
   
    }
    [self setScreenState:YES];

}
- (void)setScreenState:(BOOL)state{
    (!state)?[SVProgressHUD show]:[SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:state];
    UIBarButtonItem *leftbutton = self.navigationItem.leftBarButtonItem;
    leftbutton.enabled = state;
}
- (IBAction)signInWithFB:(id)sender {
 
}

- (IBAction)forgotPassword:(id)sender {
}

- (IBAction)signUp:(id)sender {
}
@end
