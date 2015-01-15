//
//  SettingsViewController.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/18/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "SettingsViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "User.h"
#import "SharedManager.h"
#import "SVProgressHUD.h"
#import "Constants.h"
#import "Chameleon.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface SettingsViewController ()
{
    User * spaUser;
    BOOL flag;

}
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.view.backgroundColor=[UIColor colorWithGradientStyle:UIGradientStyleRadial withFrame:self.view.frame andColors:[NSArray arrayWithObjects:[UIColor colorWithFlatVersionOf:FlatWhite], [UIColor colorWithFlatVersionOf:FlatWatermelon],nil]];
    // Do any additional setup after loading the view.
    //[self loadData];
    if([[SharedManager sharedManager]isFacebook])
    {
        self.editBarBtn.enabled=false;
        self.editBarBtn.title=@"";
    }
    spaUser=[[User alloc]init];
    
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2;
    self.profileImg.clipsToBounds = YES;
    if([[SharedManager sharedManager]userProfile].name !=nil)
    {
        self.mobileNumberTxt.text=[NSString stringWithFormat:@"%li",(long)[[SharedManager sharedManager]userProfile].mobileNumber];
        self.nameTxt.text=[[SharedManager sharedManager]userProfile].name;
        self.emailTxt.text=[[SharedManager sharedManager]userProfile].emailAddress;
        self.pointsLbl.text=[NSString stringWithFormat:@"%li",(long)[[SharedManager sharedManager]userProfile].loyaltyPoints];
        __block UIImage *MyPicture = [[UIImage alloc]init];
        PFFile *imageFile = [[SharedManager sharedManager]userProfile].profileImage;
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
            if (!error) {
                MyPicture = [UIImage imageWithData:data];
                [self.profileImg setBackgroundImage:MyPicture forState:UIControlStateNormal] ;
            }
        }];;
        
      //  [self.otherEditBtn setTitle:@"Edit Profile" forState:UIControlStateNormal];
      
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In First"
                                                        message:@"Please Login First !!"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Dismiss", nil];
        [alert show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData {
    [self setScreenState:NO];
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            [self setScreenState:YES];
            
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            NSString *location = userData[@"location"][@"name"];
            NSString *gender = userData[@"gender"];
            NSString *birthday = userData[@"birthday"];
            NSString *relationship = userData[@"relationship_status"];
            // URL should point to https://graph.facebook.com/{facebookId}/picture?type=large&return_ssl_resources=1
            self.userNameLbl.text=name;
            spaUser.name=name;
            spaUser.emailAddress =userData[@"email"];
            [[SharedManager sharedManager]setUserProfile:spaUser];
            //spaUser.userName=_usernameTxt.text;
            //  spaUser.mobileNumber= [user[@"Mobile_Number"]integerV
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
            
            // Run network request asynchronously
            [NSURLConnection sendAsynchronousRequest:urlRequest
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:
             ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                 if (connectionError == nil && data != nil) {
                     // Set the image in the header imageView
                     //  self.userProfileImage.image = [UIImage imageWithData:data];
                 }
             }];
            [self setScreenState:YES];
            
        }
        else
        {
            [self setScreenState:YES];
            
        }
    }];
    
}

- (IBAction)editPressed:(id)sender {
    if([self.editBarBtn.title isEqualToString:@"Edit"])
    {
       // [self.nameTxt setEnabled:YES];
        [self.mobileNumberTxt setEnabled:YES];
       // [self.emailTxt setEnabled:YES];
        [self.mobileNumberTxt becomeFirstResponder];
        [self.editBarBtn setTitle:@"Done"];
    }
    else
    {
        //done
        //[self.nameTxt setEnabled:NO];
        [self.mobileNumberTxt setEnabled:NO];
        //[self.emailTxt setEnabled:NO];
        [self.view endEditing:YES];
        [self.editBarBtn setTitle:@"Edit"];
        // save data to parse
        [self updateUserData];
        
    }
    
}
- (IBAction)otherEditBtnPressed:(id)sender {
    if([self.otherEditBtn.titleLabel.text isEqualToString:@"Edit Profile"])
    {
        //[self.nameTxt setEnabled:YES];
        [self.mobileNumberTxt setEnabled:YES];
        //[self.emailTxt setEnabled:YES];
        [self.mobileNumberTxt becomeFirstResponder];
        [self.otherEditBtn setTitle:@"Done" forState:UIControlStateNormal];
    }
    else
    {
        //done
        //[self.nameTxt setEnabled:NO];
        [self.mobileNumberTxt setEnabled:NO];
        //[self.emailTxt setEnabled:NO];
        [self.view endEditing:YES];
        [self.otherEditBtn setTitle:@"Edit Profile" forState:UIControlStateNormal];
        // save data to parse
        [self updateUserData];
        
    }
}

-(void)updateUserData
{
    PFUser *currentUser = [PFUser currentUser];
    NSString *userID = currentUser.objectId;
    NSLog(@"Parse User ObjectID: %@",userID);
    currentUser[@"Name"]=_nameTxt.text;
    currentUser[@"Mobile_Number"]=[NSNumber numberWithDouble:[_mobileNumberTxt.text doubleValue]];
    currentUser.email=_emailTxt.text;
    [currentUser saveInBackground ];

  //  [currentUser setEmail:_emailTxt.text];
    //[currentUser setObject:_nameTxt.text forKey:@"Name"];
    //[currentUser setObject:_mobileNumberTxt.text forKey:@"Mobile_Number"];
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            spaUser.emailAddress=currentUser.email;
            spaUser.mobileNumber=[_mobileNumberTxt.text doubleValue];
            spaUser.name=_nameTxt.text;
            spaUser.loyaltyPoints=[[SharedManager sharedManager]userProfile].loyaltyPoints;
            spaUser.userName=[[SharedManager sharedManager]userProfile].userName;

            [[SharedManager sharedManager]setUserProfile:spaUser];
            
            SHOW_ALERT(@"Successfully", @"Profile Updated ");
        } else {
            SHOW_ALERT(@"Error", @"Internal Error");
        }
    }];
    
    
}
- (void)setScreenState:(BOOL)state{
    (!state)?[SVProgressHUD show]:[SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:state];
    UIBarButtonItem *leftbutton = self.navigationItem.leftBarButtonItem;
    leftbutton.enabled = state;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   	if (textField == self.nameTxt) {
        [textField resignFirstResponder];
        [_emailTxt becomeFirstResponder];
    }
    else if (textField ==_emailTxt ) {
        [textField resignFirstResponder];
        [_mobileNumberTxt becomeFirstResponder];
    }
    else if (textField == _mobileNumberTxt) {
        [textField resignFirstResponder];
    }
    return YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)profileImg:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]
                                                 init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
    
}
- (IBAction)changeBackgroundImage:(id)sender {
    flag=YES;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]
                                                 init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}
#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    if(flag)
    {
        [self.userProfileImage setImage:image];
    }
    else
    {
        [self.profileImg setBackgroundImage:image forState:UIControlStateNormal];;
    }
    [self dismissModalViewControllerAnimated:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *selectedImg = info[UIImagePickerControllerOriginalImage];
    [self.profileImg setBackgroundImage:selectedImg forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
   
        NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
        {
            ALAssetRepresentation *representation = [myasset defaultRepresentation];
            NSString *fileName = [representation filename];
            NSLog(@"fileName : %@",fileName);
            
            PFUser *currentUser = [PFUser currentUser];
            NSData* data = UIImageJPEGRepresentation(_profileImg.currentBackgroundImage, 0.5f);
            PFFile *imageFile = [PFFile fileWithName:fileName data:data];
            //
            // Save the image to Parse
            
            [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    // The image has now been uploaded to Parse. Associate it with a new object
                   // PFObject* newPhotoObject = [PFObject objectWithClassName:@"PhotoObject"];
                    [currentUser setObject:imageFile forKey:@"ProfilePicture"];
                    
                    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
                            NSLog(@"Saved");
                            spaUser.profileImage=imageFile;
                            spaUser.emailAddress=currentUser.email;
                            spaUser.mobileNumber=[_mobileNumberTxt.text doubleValue];
                            spaUser.name=_nameTxt.text;
                            spaUser.loyaltyPoints=[[SharedManager sharedManager]userProfile].loyaltyPoints;
                            spaUser.userName=[[SharedManager sharedManager]userProfile].userName;

                            [[SharedManager sharedManager]setUserProfile:spaUser];
                      
                        }
                        else{
                            // Error
                            NSLog(@"Error: %@ %@", error, [error userInfo]);
                        }
                    }];
                }
            }];
        };
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:imageURL
                       resultBlock:resultblock
                      failureBlock:nil];
        
}
    


@end
