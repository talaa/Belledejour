//
//  SignUpViewController.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/6/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "SignUpViewController.h"
#import "User.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"

@interface SignUpViewController ()
{
    User *user;
    UIAlertController *alertController ;
    PFUser * parseUser;
}

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    user = [[User alloc]init];
    parseUser = [PFUser user];
    alertController = [UIAlertController
                       alertControllerWithTitle:@"Alert"
                       message:[NSString stringWithFormat:@"%@ %@",@"Please enter all fields ! ",@""]
                       preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction *action)
                                {
                                    NSLog(@"OK action");
                                }];
    [alertController addAction:okAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setScreenState:(BOOL)state{
    (!state)?[SVProgressHUD show]:[SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:state];
    UIBarButtonItem *leftbutton = self.navigationItem.leftBarButtonItem;
    leftbutton.enabled = state;
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
-(void)insertUserData
{
    if(_emailTxt.text.length>0&&_nameTxt.text.length>0&&_userNameTxt.text.length>0&&_passwordTxt.text.length>0&&_mobileNumberTxt.text.length>0)
    {
        user.name=_nameTxt.text;
        user.userName=_userNameTxt.text;
        user.password=_passwordTxt.text;
        user.emailAddress=_emailTxt.text;
        user.mobileNumber=[_mobileNumberTxt.text integerValue];
        parseUser.username = user.userName;
        parseUser.password =user.password;
        parseUser.email = user.emailAddress;
        parseUser[@"Name"] = user.name;
        parseUser[@"Mobile_Number"]=[NSNumber numberWithInteger:user.mobileNumber];

       // [NSString stringWithFormat:@"%li", (long)user.mobileNumber] ;
        
        [parseUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully Created" message:@"Please check your mail inbox to verify your account!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internal Error" message:[error userInfo][@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }];
        //        PFObject *newUser = [PFObject objectWithClassName:@"User"];
        //        [newUser setObject:user.name forKey:@"Name"];
        //        [newUser setObject:[NSString stringWithFormat:@"%li", (long)user.mobileNumber]  forKey:@"Mobile_Number"];
        //        [newUser setObject:user.userName forKey:@"username"];
        //        [newUser setObject:user.password forKey:@"password"];
        //        [newUser setObject:user.emailAddress forKey:@"email"];
        //        [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //
        //            if (!error) {
        //                // Show success message
        //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successfully Created" message:@"Please check your mail inbox to verify your account!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //                [alert show];
        //                _nameTxt.text=nil;
        //                _passwordTxt.text=nil;
        //                _userNameTxt.text=nil;
        //                _mobileNumberTxt.text=nil;
        //                _emailTxt.text=nil;
        //            } else {
        //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internal Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //                [alert show];
        //
        //            }
        //
        //        }];
        
    }
    else
    {
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}
- (IBAction)createAccount:(id)sender {
    [self setScreenState:NO];
    [self insertUserData];
    [self setScreenState:YES];
    
    
}
@end
