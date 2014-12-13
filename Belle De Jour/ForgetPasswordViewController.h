//
//  ForgetPasswordViewController.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/13/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForgetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailAddresTxt;
- (IBAction)sendPressed:(id)sender;

@end
