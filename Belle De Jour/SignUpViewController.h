//
//  SignUpViewController.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/6/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
- (IBAction)createAccount:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *createAccountBtn;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;

@end
