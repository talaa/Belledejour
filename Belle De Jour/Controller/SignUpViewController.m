//
//  SignUpViewController.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/6/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "SignUpViewController.h"
#import "User.h"
#import "SVProgressHUD.h"
#import "Constants.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NetworkRequester.h"
#import "DataParsing.h"
#import "AppConstants.h"

@interface SignUpViewController ()
{
    NSURL *downloadURL;
    UIAlertController *alertController ;
    NSString * profileImgUrl;
}

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ShowInternetIndicator;
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2;
    self.profileImg.clipsToBounds = YES;
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
    //    if(IS_IPHONE_5)
    //    {
    //        self.createAccountBtn.frame=CGRectMake(_createAccountBtn.frame.origin.x,[[UIScreen mainScreen] bounds].size.height-_createAccountBtn.frame.size.height-63, _createAccountBtn.frame.size.width, _createAccountBtn.frame.size.height);
    //    }
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
    if(_emailTxt.text.length >0 && _nameTxt.text.length >0 && _passwordTxt.text.length >0 && _mobileNumberTxt.text.length > 0)
    {
        if([self validEmail:_emailTxt.text ])
        {
            // loading
            [SVProgressHUD show];
            
            NSData* imageData = UIImageJPEGRepresentation(_profileImg.image, 0.5f);
            
            //correct data -> save new user to firebase
            [NetworkRequester createFireBaseUserAccount:_emailTxt.text Password:_passwordTxt.text  completionBlock:^(NSError *error, FIRUser *user) {
                if (!error){
                    //new user account has been saved
                
                    //1- upload user profile
                    [NetworkRequester uploadfilePathName:[NSString stringWithFormat:@"ProfilePic/%@.png",user.uid] Data:imageData Completion:^(FIRStorageMetadata *metadata, NSError *error) {
                        if (error != nil){
                            //there is an error
                            [SVProgressHUD dismiss];
                            //2- alert to notify user
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coould not save your profile now, please try again" message:error.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            [self presentViewController:alertController animated:YES completion:nil];
                        }else{
                            //save image successfully
                            downloadURL = metadata.downloadURL;
                            //user data Dictionary
                            NSDictionary *userDatadictionary = [NSDictionary dictionaryWithObjectsAndKeys:user.uid, UsersId, _nameTxt.text, UsersName,_emailTxt.text,UsersEmail,_mobileNumberTxt.text,UsersPhone,downloadURL.absoluteString,UsersPhotoURL,nil];
                            //save user data -> Firebase
                            [NetworkRequester addUserDataFireBaseDBb:userDatadictionary User:user];
                            //there is an error
                            [SVProgressHUD dismiss];
                        }
                    }];
                }else{
                    //failed to create user account to authenticat with
                    //1- dismiss loading
                    [SVProgressHUD dismiss];
                    //2- alert to notify user
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internal Error" message:error.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }];
            
        }else{
            //email address is not valid
            //1- dismiss loading
            [SVProgressHUD dismiss];
            //2- alert to notify user
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@" Please enter valid E-mail address . "delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else{
        //some data is missing
        //email address is not valid
        //1- dismiss loading
        [SVProgressHUD dismiss];
        //2- alert to notify user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@" Please enter all data "delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)changeProfilePicture:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]
                                                 init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (BOOL) validEmail:(NSString*) emailString {
    if([emailString length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
    NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)createAccount:(id)sender {
    //[self setScreenState:NO];
    [self insertUserData];
}
#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        NSString *fileName = [representation filename];
        NSLog(@"fileName : %@",fileName);
        // picker.delegate=self;
        // self.profileImg.image=[UIImage imageNamed:[NSString string]]
        UIImage *selectedImg = info[UIImagePickerControllerOriginalImage];
        self.profileImg.image=selectedImg;
        profileImgUrl=fileName;
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
    
}



@end
