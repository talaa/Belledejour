//
//  ContactUsViewController.h
//  Belle De Jour
//
//  Created by Nada Gamal on 1/7/15.
//  Copyright (c) 2015 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ContactUsViewController : UIViewController<MKAnnotation>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)socialNetworkPressed:(id)sender;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@end
