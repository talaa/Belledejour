//
//  FeedbackViewController.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 2/2/15.
//  Copyright (c) 2015 SpringMoon. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
{
    UIPickerView * serviceRatingPickerView;
    UIPickerView * overAllRatingPickerView;

    UIToolbar *toolBar;
}
@property (nonatomic)NSArray *servicerating;
@property (nonatomic)NSArray *overallrating;
@property (nonatomic)NSArray *recommendyesno;
@property (nonatomic)int indexpicker;


@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  serviceRatingPickerView = [[UIPickerView alloc] init];
    overAllRatingPickerView = [[UIPickerView alloc] init];

    _servicerating=@[@"Excellent",@"Very Good",@"Good",@"Fair"];
    _overallrating=@[@"Excellent",@"Very Good",@"Good",@"Fair"];
    _recommendyesno=@[@"YES",@"NO"];
    // Do any additional setup after loading the view.
    [_sendmessage.layer setCornerRadius:35.0f];
    [_sendmessage.layer setMasksToBounds:YES];
    self.title=@"Feedback";
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+150)];
    toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen]bounds].size.width,44)];
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(doneToolbarPressed:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    
 
    

    barButtonDone.tintColor=[UIColor blackColor];
  //  [serviceRatingPickerView addSubview:toolBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)sendmessage:(id)sender{
    NSString *recommendation=[[NSString alloc]init];
    if (_recommendationfield.isOn) {
        recommendation=@"Yes ,i will recommend you to my friends ";
    }else{
    recommendation=@"Sorry , but i will not recommend you";
    }

    MFMailComposeViewController * messageScreen=[[MFMailComposeViewController alloc]init];
    messageScreen.mailComposeDelegate=self;
    [messageScreen setSubject:_messagetitle.text ];
    [messageScreen setToRecipients:@[@"info@belledejour.ae"]];
    NSString *messagebodytext;
    if(!_recommendationfield.isOn)
    {
   messagebodytext=[[NSString alloc]initWithFormat:@"I have Found the Service %@ \nand over all rating of the clinic %@ \n and %@ \nHere is My Feedback: %@",_serviceratingfield.text,_overallratingfield.text,recommendation,_messagebody.text,nil];
    }
    else
    {
           messagebodytext=[[NSString alloc]initWithFormat:@"I have Found the Service %@ \nand over all rating of the clinic %@ \n and %@ Friend mobile number is : %@  \nHere is My Feedback: %@",_serviceratingfield.text,_overallratingfield.text,recommendation, _phoneNumberTxt.text,_messagebody.text,nil];
    }
    [messageScreen setMessageBody:messagebodytext isHTML:NO];
    //[picker addAttachmentData:[self.detailItem valueForKey:@"image"] mimeType:@"image/png" fileName:@"Photos"];
    //[self dismissViewControllerAnimated:YES completion:NULL];
    [self presentViewController:messageScreen animated:YES completion:nil];




}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
        switch (result){
        case MFMailComposeResultCancelled:
        NSLog(@"Mail cancelled");
        break;
        case MFMailComposeResultSaved:
        NSLog(@"Mail saved");
        break;
        case MFMailComposeResultSent:
        NSLog(@"Mail sent");
        break;
        case MFMailComposeResultFailed:
        NSLog(@"Mail sent failure: %@", [error localizedDescription]);
        break;
        default:
        break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)recommendrating:(id)sender{


}
-(IBAction)servrating:(id)sender{
    //[_serviceratingfield resignFirstResponder];
    serviceRatingPickerView.hidden=NO;

    serviceRatingPickerView.dataSource = self;
    serviceRatingPickerView.delegate = self;
    serviceRatingPickerView.showsSelectionIndicator=YES;
    _indexpicker=1;
    _serviceratingfield.inputView=serviceRatingPickerView;
    _serviceratingfield.inputAccessoryView=toolBar;
    [serviceRatingPickerView reloadComponent:0];



}
-(void)doneToolbarPressed:(id)sender
{
    serviceRatingPickerView.hidden=YES;
    overAllRatingPickerView.hidden=YES;

    [_serviceratingfield endEditing:YES];
    [_overallratingfield endEditing:YES];

    
}
-(IBAction)overallrating:(id)sender{
   // serviceRatingPickerView = [[UIPickerView alloc] init];
    overAllRatingPickerView.hidden=NO;

    //[_overallratingfield resignFirstResponder];
  //  UIPickerView *picker1 = [[UIPickerView alloc] init];
    overAllRatingPickerView.dataSource = self;
    overAllRatingPickerView.delegate = self;
    overAllRatingPickerView.showsSelectionIndicator=YES;
    _indexpicker=2;
    _overallratingfield.inputView=overAllRatingPickerView;
    _overallratingfield.inputAccessoryView=toolBar;
   // [overAllRatingPickerView reloadInputViews];
   // [overAllRatingPickerView reloadComponent:0];

   [overAllRatingPickerView reloadComponent:0];




}
//Prepare th UI
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView==serviceRatingPickerView)
    return [_servicerating count];
    else if (pickerView==overAllRatingPickerView)
        return [_overallrating count];

    else
        return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView==serviceRatingPickerView)
    return _servicerating[row];
    else if (pickerView==overAllRatingPickerView)
        return _overallrating[row];
    else
    return nil;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (_indexpicker==1) {
        _serviceratingfield.text= _servicerating[row];
    }
    else{
        _overallratingfield.text=_overallrating[row];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
        
}
#pragma textField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+160)];

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-160)];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.scrollView endEditing:YES];
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

- (IBAction)switchChanged:(id)sender {
    if(_recommendationfield.isOn)
    {
        _phoneNumberLbl.hidden=NO;
        _phoneNumberTxt.hidden=NO;
    }
    else
    {
        _phoneNumberLbl.hidden=YES;
        _phoneNumberTxt.hidden=YES;
        
    }
}
@end
