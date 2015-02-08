//
//  FeedbackViewController.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 2/2/15.
//  Copyright (c) 2015 SpringMoon. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
@property (nonatomic)NSArray *servicerating;
@property (nonatomic)NSArray *overallrating;
@property (nonatomic)NSArray *recommendyesno;
@property (nonatomic)int indexpicker;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _servicerating=@[@"Excellent",@"Very Good",@"Good",@"Fair"];
    _overallrating=@[@"Excellent",@"Very Good",@"Good",@"Fair"];
    _recommendyesno=@[@"YES",@"NO"];
    // Do any additional setup after loading the view.
    [_sendmessage.layer setCornerRadius:35.0f];
    [_sendmessage.layer setMasksToBounds:YES];
    self.title=@"Feedback";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)sendmessage:(id)sender{
    NSString *recommendation=[[NSString alloc]init];
    if (_recommendationfield.state) {
        recommendation=@"Yes ,i will recommend you to my friends ";
    }else{
    recommendation=@"Sorry , but i will not recommend you";
    }

    MFMailComposeViewController *picker=[[MFMailComposeViewController alloc]init];
    picker.mailComposeDelegate=self;
    [picker setSubject:_messagetitle.text ];
    [picker setToRecipients:@[@"info@belledejour.ae"]];
    NSString *messagebodytext=[[NSString alloc]initWithFormat:@"I have Found the Service %@ \nand over all rating of the clinic %@ \n and %@ \nHere is My Feedback: %@",_serviceratingfield.text,_overallratingfield.text,recommendation,_messagebody.text,nil];
    [picker setMessageBody:messagebodytext isHTML:NO];
    //[picker addAttachmentData:[self.detailItem valueForKey:@"image"] mimeType:@"image/png" fileName:@"Photos"];
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self presentViewController:picker animated:YES completion:nil];




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
-(IBAction)servrating:(id)sender;{
    //[_serviceratingfield resignFirstResponder];
    UIPickerView *picker1 = [[UIPickerView alloc] init];
    
    picker1.dataSource = self;
    picker1.delegate = self;
    picker1.showsSelectionIndicator=YES;
    _indexpicker=1;
    _serviceratingfield.inputView=picker1;
}
-(IBAction)overallrating:(id)sender{
    //[_overallratingfield resignFirstResponder];
    UIPickerView *picker1 = [[UIPickerView alloc] init];
    
    picker1.dataSource = self;
    picker1.delegate = self;
    picker1.showsSelectionIndicator=YES;
    _indexpicker=2;
    _overallratingfield.inputView=picker1;




}
//Prepare th UI
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_servicerating count];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (_indexpicker==1) {
        return _servicerating[row];
    }
    else{
        return _overallrating[row];
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
