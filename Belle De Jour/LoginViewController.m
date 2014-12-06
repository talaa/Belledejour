//
//  LoginViewController.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/4/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //   self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login Screen"]];
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
#pragma UITextField delegate
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
}

- (IBAction)signInWithFB:(id)sender {
}

- (IBAction)forgotPassword:(id)sender {
}

- (IBAction)signUp:(id)sender {
}
@end
