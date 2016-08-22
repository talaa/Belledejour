//
//  ContactUsViewController.m
//  Belle De Jour
//
//  Created by Nada Gamal on 1/7/15.
//  Copyright (c) 2015 SpringMoon. All rights reserved.
//

#import "ContactUsViewController.h"
#import <MapKit/MapKit.h>
#import "Constants.h"
@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    
    CGFloat latitude = 25.117409;
    CGFloat longitude = 55.204704;
    NSString *title = @"Belle De Jour Spa";
    //Create coordinates from the latitude and longitude values
    CLLocationCoordinate2D coord;
    coord.latitude = latitude;
    coord.longitude = longitude;
    MKPointAnnotation *annotation=[[MKPointAnnotation alloc]init];
    annotation.coordinate=coord;
    annotation.title=title;
    [self.mapView addAnnotation:annotation];
    [self zoomToLocation];
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*3, 0.5*3);
//    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
//    [_mapView setRegion:adjustedRegion animated:YES];
}
- (void)zoomToLocation
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 25.117409;
    zoomLocation.longitude= 55.204704;
    // create a region and pass it to the Map View
    MKCoordinateRegion region;
    region.center.latitude = 25.117409;
    region.center.longitude = 55.204704;
    region.span.latitudeDelta = 0.001;
    region.span.longitudeDelta = 0.001;
    
    [self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)socialNetworkPressed:(id)sender {
    if([sender tag]==0)
    {
        NSString *fileName= @"fb://profile/443490909081311";
        NSURL *facebookURL = [NSURL URLWithString:fileName];
        if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
            [[UIApplication sharedApplication] openURL:facebookURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com"]];
        }
    }
    else if([sender tag]==1)
    {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/110272763573140896569/about?gl=eg&hl=en"]];
    }
   else if([sender tag]==2)
    {
        NSString *fileName= @"twitter://user?screen_name=bdjmedicalspa";
        NSURL *facebookURL = [NSURL URLWithString:fileName];
        if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
            [[UIApplication sharedApplication] openURL:facebookURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com"]];
        }
    }
   else if([sender tag]==3)
   {
//       NSString *fileName= @"twitter://user?screen_name=bdjmedicalspa";
//       NSURL *facebookURL = [NSURL URLWithString:fileName];
//       if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
//           [[UIApplication sharedApplication] openURL:facebookURL];
//       } else {
//           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com"]];
//       }
   }
    
}
- (IBAction)callPressed:(id)sender {
    NSString *phNo = @"+97143475336";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
    SHOW_ALERT(@"Alert", @"Call facility is not available!!!");
    }
}
@end
