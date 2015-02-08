//
//  ServicesListViewController.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/10/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesListViewController : UIViewController<UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray * services;
@property (strong, nonatomic) IBOutlet UITableView *servicesTableView;
@property(nonatomic,strong)NSString * selectedCategory;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItemTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *servicesCollectionView;
@end
