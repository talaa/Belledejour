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
#import "RESideMenu.h"
#import "SharedManager.h"
@interface LoginViewController ()
{
    UIAlertController * alertController;
    UIAlertAction * oKAction;
    User * spaUser;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowInternetIndicator;
    spaUser=[[User alloc]init];
    oKAction = [UIAlertAction
                actionWithTitle:@"OK"
                style:UIAlertActionStyleCancel
                handler:^(UIAlertAction *action)
                {
                    NSLog(@"OK action");
                }];
    if([[SharedManager sharedManager]isbooked])
    {
        self.dismissBtn.hidden=NO;

    }
    else
    {
        self.dismissBtn.hidden=YES;
    }
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
-(void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];

    [((LeftViewController *)(delegate.viewController.leftMenuViewController)).tableView reloadData];

}
#pragma mark - UITextField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+100);
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-100);
    
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
- (IBAction)signIn:(id)sender {
    
    [self setScreenState:NO];
    if(_usernameTxt.text.length>0 && _passwordTxt.text.length>0)
    {
        [PFUser logInWithUsernameInBackground:_usernameTxt.text password:_passwordTxt.text
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat: @"Welcome %@",user[@"Name"]]
                                                                                               delegate:nil
                                                                                      cancelButtonTitle:nil
                                                                                      otherButtonTitles:@"OK", nil];
                                                [alert show];
                                                spaUser.userName=_usernameTxt.text;
                                                spaUser.emailAddress =user.email;
                                                spaUser.name=user[@"Name"] ;
                                                spaUser.mobileNumber= [user[@"Mobile_Number"]integerValue];
                                                spaUser.loyaltyPoints=[user[@"LoyaltyPoints"]integerValue];
                                                PFFile *imageFile = user[@"ProfilePicture"];
                                                spaUser.profileImage=imageFile;
                                                [[SharedManager sharedManager]setUserProfile:spaUser];
                                                
                                                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController1"]]
                                                                                             animated:YES];
                                                
                                                
                                            } else {
                                                alertController = [UIAlertController
                                                                   alertControllerWithTitle:@"Alert"
                                                                   message:[NSString stringWithFormat:@"%@ ",@"Please enter valid Credentials,"]
                                                                   preferredStyle:UIAlertControllerStyleAlert];
                                                [alertController addAction:oKAction];
                                                [self presentViewController:alertController animated:YES completion:nil];                                        }
                                        }];
    }
    else
    {
        alertController = [UIAlertController
                           alertControllerWithTitle:@"Alert"
                           message:@"Please enter fields!!"
                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:oKAction];
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
                NSLog(@"User with facebook logged in!");
                [self loadData];
               

                
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
- (void)loadData {
    // ...
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            [[SharedManager sharedManager]isFacebookLogin:YES];
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            NSString *location = userData[@"location"][@"name"];
            NSString *gender = userData[@"gender"];
            NSString *birthday = userData[@"birthday"];
            NSString *relationship = userData[@"relationship_status"];
            // URL should point to https://graph.facebook.com/{facebookId}/picture?type=large&return_ssl_resources=1
            spaUser.name=name;
            spaUser.emailAddress =userData[@"email"];
            spaUser.userName=_usernameTxt.text;
            //  spaUser.mobileNumber= [user[@"Mobile_Number"]integerValue];
            PFUser *currentUser = [PFUser currentUser];

            if([currentUser[@"Mobile_Number"]integerValue]==0)
            {
            UIAlertController *alertControllerr = [UIAlertController
                                                   alertControllerWithTitle:[NSString stringWithFormat:@"Hi %@",name]
                                                  message:[NSString stringWithFormat:@"%@ , Please Enter your Mobile Number !!",name]
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            [alertControllerr addTextFieldWithConfigurationHandler:^(UITextField *textField)
             {
                 textField.placeholder = NSLocalizedString(@"MobileNumber", @"Enter your MobileNumber");
             }];
            UIAlertAction *okActionn = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           UITextField *mobileNumberTextField = alertControllerr.textFields.firstObject;
                                           [[SharedManager sharedManager]userProfile].mobileNumber=mobileNumberTextField.text.integerValue;
                                           spaUser.mobileNumber=mobileNumberTextField.text.integerValue;
                                           NSLog(@"%i",mobileNumberTextField.text.integerValue);
                                           // save mobile number in parse
                                           spaUser.loyaltyPoints=[currentUser[@"LoyaltyPoints"]integerValue];
                                           [[SharedManager sharedManager]setUserProfile:spaUser];
                                           NSString *userID = currentUser.objectId;
                                           NSLog(@"Parse User ObjectID: %@",userID);
                                           currentUser[@"Mobile_Number"]=[NSNumber numberWithInt:[mobileNumberTextField.text integerValue] ];

                                           [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                               if (!error) {
                                                   
                                                   SHOW_ALERT(@"Successfully", @"Profile Updated ");
                                                   [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController1"]]
                                                                                                animated:YES];
                                               } else {
                                                   SHOW_ALERT(@"Error", @"Internal Error");
                                               }
                                           }];

                                       }];
            [alertControllerr addAction:okActionn];
            [self presentViewController:alertControllerr animated:YES completion:nil];
            }
            else
            {
             //   [self dismissViewControllerAnimated:YES completion:nil];
                SHOW_ALERT(@"Welcome",name);
                spaUser.loyaltyPoints=[currentUser[@"LoyaltyPoints"]integerValue];
                spaUser.mobileNumber= [currentUser[@"Mobile_Number"]integerValue];
                [[SharedManager sharedManager]setUserProfile:spaUser];
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController1"]]
                                                             animated:YES];
            }
        }
    }];

}

- (IBAction)forgotPassword:(id)sender {
}

- (IBAction)signUp:(id)sender {
}
- (IBAction)dismissPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
