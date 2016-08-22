//
//  ServicesTableViewController.h
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/17/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesTableViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *servicesTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *servicesCollectionView;

@end
