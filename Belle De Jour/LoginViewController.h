//
//  LoginViewController.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/4/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,RESideMenuDelegate>
@property (weak, nonatomic) IBOutlet UITextField * usernameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
- (IBAction)signIn:(id)sender;
- (IBAction)signInWithFB:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)signUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
