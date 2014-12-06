//
//  ServicesTableViewController.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/17/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "ServicesTableViewController.h"
#import <Parse/Parse.h>
#import "Service.h"
#import "ServiceTableViewCell.h"
#import "SVProgressHUD.h"

@interface ServicesTableViewController ()
{
    NSArray * servicesList;
    Service * service;
    NSMutableArray * servicesArray;
}

@end

@implementation ServicesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(getServices)];
}
-(void)getServices
{
    [self setScreenState:NO];
    servicesArray=[[NSMutableArray alloc]init];
    PFQuery * parseServicesList=[PFQuery queryWithClassName:@"Services"];
    
    //          servicesList=  [parseServicesList findObjects];
    [parseServicesList findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for(int i=0;i<objects.count;i++)
        {
            service=[[Service alloc]init];
            service.serviceID=[[[objects objectAtIndex:i ] objectForKey:@"Service_ID"]intValue];
            service.serviceDescription=[[objects objectAtIndex:i ] objectForKey:@"Service_Description"];
            service.serviceType=[[objects objectAtIndex:i ] objectForKey:@"Service_Type"];
            service.servicePrice=[[[objects objectAtIndex:i ] objectForKey:@"Service_Price"]intValue];
            service.serviceLoyaltyPoints=[[[objects objectAtIndex:i ] objectForKey:@"Service_Loyalty_Points"]integerValue];
            service.serviceImage=[[objects objectAtIndex:i ] objectForKey:@"Service_Picture"];
            [servicesArray addObject:service ];
        }
        [_servicesTableView reloadData];
        
    }];
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return servicesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"serviceTableCell";
    
    ServiceTableViewCell *cell = [tableView
                                  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    if(servicesArray.count>0)
    {
        [self setScreenState:YES];
        cell.serviceIDLbl.text=[NSString stringWithFormat:@"%i",[[servicesArray objectAtIndex:indexPath.row]serviceID]];
        cell.servicePriceLbl.text=[NSString stringWithFormat:@"%i",[[servicesArray objectAtIndex:indexPath.row]servicePrice]];
        cell.serviceDescriptionTxtView.text=[NSString stringWithFormat:@"%@",[[servicesArray objectAtIndex:indexPath.row]serviceDescription]];
        __block UIImage *MyPicture = [[UIImage alloc]init];
        PFFile *imageFile = [[servicesArray objectAtIndex:indexPath.row]serviceImage];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
            if (!error) {
                MyPicture = [UIImage imageWithData:data];
                cell.serviceImg.image = MyPicture;
            }
        }];;
    }
    
    return cell;
}
- (void)setScreenState:(BOOL)state{
    (!state)?[SVProgressHUD show]:[SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:state];
    UIBarButtonItem *leftbutton = self.navigationItem.leftBarButtonItem;
    leftbutton.enabled = state;
}


@end
