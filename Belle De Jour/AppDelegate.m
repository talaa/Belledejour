//
//  AppDelegate.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/17/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "AppDelegate.h"
#import "TestFlight.h"
#import <Parse/Parse.h>
#import "RESideMenu.h"
#import "LeftViewController.h"
#import "HomeViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _navigationController = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    _sideBar=[[LeftViewController alloc]init];
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:0.8366928522 green:0.097945066159999997 blue:0.46180832659999999 alpha:1] ];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.8366928522 green:0.097945066159999997 blue:0.46180832659999999 alpha:1] ];
    self.viewController = [[RESideMenu alloc]initWithContentViewController:_navigationController leftMenuViewController:_sideBar rightMenuViewController:nil];
    [Parse setApplicationId:@"2Fqeb69D9uPkqmEfbW99r3LWjUefv0pIyQL4QdgR"
                  clientKey:@"Qpafs6h3B4jEkPVk2DNTHo4GUICHkfUgTByH8lng"];
    [PFFacebookUtils initializeFacebook];
    
    [TestFlight takeOff:@"a00986c3-fffa-4d60-94a3-09d8ce957115"];
    return YES;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[PFFacebookUtils session] close];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



@end
