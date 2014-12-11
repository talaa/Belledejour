//
//  Constants.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/8/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//
#import "SMBInternetConnectionIndicator.h"

#ifndef Belle_De_Jour_Constants_h
#define Belle_De_Jour_Constants_h
#define ShowInternetIndicator CGRect screenRect = [[UIScreen mainScreen] bounds]; SMBInternetConnectionIndicator * internetConnectionIndicator=[[SMBInternetConnectionIndicator alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 30, screenRect.size.width, 30)]; [self.view addSubview:internetConnectionIndicator];
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height > 480)

#endif
