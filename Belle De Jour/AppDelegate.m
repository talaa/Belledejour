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
#import "Chameleon.h"
#import "NetworkRequester.h"
#import "DataParsing.h"
#import "AppConstants.h"
@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _navigationController=  (UINavigationController *)self.window.rootViewController;
    _sideBar = [_navigationController.storyboard instantiateViewControllerWithIdentifier:@"leftMenuViewController"];
    HomeViewController *home=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController1"]; //or the homeController
    _navigationController=[[UINavigationController alloc]initWithRootViewController:home];
    //self.window.rootViewController=_navigationController;
    // _sideBar = [_navigationController.storyboard instantiateViewControllerWithIdentifier:@"leftMenuViewController"];
    self.viewController = [[RESideMenu alloc]initWithContentViewController:_navigationController leftMenuViewController:_sideBar rightMenuViewController:nil];
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    // [self.navigationController.navigationBar setTitleTextAttributes:
    //[NSDictionary dictionaryWithObjectsAndKeys:
    // [UIFont fontWithName:@"Optima" size:9],
    //NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], UITextAttributeTextColor,
                                                           [UIColor clearColor],UITextAttributeTextShadowColor,
                                                           [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
                                                           UITextAttributeTextShadowOffset,
                                                           [UIFont fontWithName:@"BrandonGrotesque-Bold" size:16.0], UITextAttributeFont, nil]];
    
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
    //  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    //self.navigationController.view.backgroundColor = [UIColor clearColor];
    //  self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
   // [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithFlatVersionOf:FlatWatermelon]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithFlatVersionOf:FlatMintDark]];
    
    self.navigationController. edgesForExtendedLayout = UIRectEdgeAll;
    self.navigationController. automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController. extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = YES;
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.5159 green:0.8254 blue:0.3810 alpha:0.8631]];
    //   UIImage *navBackgroundImage = [UIImage imageNamed:@"navgationBar.png"];
    // [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    //self.viewController = [[RESideMenu alloc]initWithContentViewController:_navigationController leftMenuViewController:_sideBar rightMenuViewController:nil];
    [Parse setApplicationId:@"2Fqeb69D9uPkqmEfbW99r3LWjUefv0pIyQL4QdgR"
                  clientKey:@"Qpafs6h3B4jEkPVk2DNTHo4GUICHkfUgTByH8lng"];
    [PFFacebookUtils initializeFacebook];
    
    [TestFlight takeOff:@"a00986c3-fffa-4d60-94a3-09d8ce957115"];
    
    // Use Firebase library to configure APIs
    [FIRApp configure];
    
    //save ReferenceFirebaseDatabase
    [DataParsing getInstance].referenceFirebaseDatabase = [[FIRDatabase database] reference];
    
    //save FirebaseStorage
    [DataParsing getInstance].firebaseStorage = [FIRStorage storage];
    
    //save ReferenceFirebaseStroage
    [DataParsing getInstance].referenceFirebaseStorage = [[DataParsing getInstance].firebaseStorage referenceForURL:FireBaseStorageURL];

    
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
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [FBSession.activeSession handleOpenURL:url];
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
