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
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "AppDelegate.h"
#import "SettingsViewController.h"
#import "User.h"
#import "SharedManager.h"

@interface LoginViewController ()
{
    UIAlertController * alertController;
    UIAlertAction * okAction;
    User * spaUser;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowInternetIndicator;
    spaUser=[[User alloc]init];
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
                                                spaUser.userName=_usernameTxt.text;
                                                spaUser.emailAddress =user.email;
                                                spaUser.name=user[@"Name"] ;
                                                spaUser.mobileNumber= [user[@"Mobile_Number"]integerValue];
                                                [[SharedManager sharedManager]setUserProfile:spaUser];
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
    // Set permissions required from the facebook user account
   [self setScreenState:NO];
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [self setScreenState:YES];

        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        } else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
            } else {
                spaUser.userName=user.username;
                spaUser.emailAddress =user.email;
                spaUser.name=user[@"Name"] ;
              //  spaUser.mobileNumber= [user[@"Mobile_Number"]integerValue];
                [[SharedManager sharedManager]setUserProfile:spaUser];
                NSLog(@"User with facebook logged in!");
                if([[SharedManager sharedManager]isbooked])
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successufly"
                                                                    message:[NSString stringWithFormat:@"Welcome %@",user[@"Name"]]
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"OK", nil];
                    [alert show];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                else
                {
                [self presentSettingsViewController];
                }
                
            }
        }
    }];
    
    
}
-(void)presentSettingsViewController
{
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"]]
                                                 animated:YES];
    [self setScreenState:YES];

}

- (IBAction)forgotPassword:(id)sender {
}

- (IBAction)signUp:(id)sender {
}
@end
