//
//  AppDelegate.h
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/17/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "LeftViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RESideMenu *viewController;
@property(strong,nonatomic)LeftViewController * sideBar;
@property(strong,nonatomic) UINavigationController *navigationController;



@end

