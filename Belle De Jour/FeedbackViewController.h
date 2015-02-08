//
//  FeedbackViewController.h
//  Belle De Jour
//
//  Created by Tamer Alaa on 2/2/15.
//  Copyright (c) 2015 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface FeedbackViewController : UIViewController<MFMailComposeViewControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)IBOutlet UITextField *messagebody;
@property (nonatomic,strong)IBOutlet UITextField *messagetitle;
@property (nonatomic,strong)IBOutlet UITextField *serviceratingfield;
@property (nonatomic,strong)IBOutlet UITextField *overallratingfield;
@property (nonatomic,strong)IBOutlet UISwitch *recommendationfield;
@property (nonatomic,strong)IBOutlet UIButton *sendmessage;
-(IBAction)sendmessage:(id)sender;
-(IBAction)servrating:(id)sender;
-(IBAction)overallrating:(id)sender;
-(IBAction)recommendrating:(id)sender;
@end
