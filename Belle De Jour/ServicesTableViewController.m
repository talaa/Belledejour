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
#import "SMBInternetConnectionIndicator.h"
#import "SVProgressHUD.h"
#import "Constants.h"
#import "ServicesListViewController.h"

@interface ServicesTableViewController ()
{
    NSArray * servicesList;
    Service * service;
    NSMutableArray * servicesArray;
    NSMutableArray * temparray;
    NSString * selectedCategory;
    NSMutableArray * otherServicesArray;
}

@end

@implementation ServicesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowInternetIndicator;
    [self performSelector:@selector(getServices)];
    otherServicesArray=[[NSMutableArray alloc]init];
    servicesList=[[NSArray alloc]init];
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
            service.serviceName=[[objects objectAtIndex:i ] objectForKey:@"Service_Name"];
            [servicesArray addObject:service ];
           [otherServicesArray insertObject:service atIndex:i];

        }
        
        int count=otherServicesArray.count;
        for(int j=0;j<count;j++)
        {
            for(int k=0;k<count;k++)
            {
                if([[[otherServicesArray objectAtIndex:j]serviceType]isEqualToString:[[otherServicesArray objectAtIndex:k]serviceType]])
                {
                    if(j!=k)
                    {
                        [otherServicesArray removeObjectAtIndex:k];
                        count --;
                        
                    }
                }
            }
            
        }
        [_servicesTableView reloadData];
        [self setScreenState:YES];
        
        
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
    return otherServicesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ServiceCell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    if(otherServicesArray.count>0)
    {
        cell.textLabel.text=[[otherServicesArray objectAtIndex:indexPath.row]serviceType];
        //  cell.serviceIDLbl.text=[NSString stringWithFormat:@"%i",[[servicesArray objectAtIndex:indexPath.row]serviceID]];
        // cell.servicePriceLbl.text=[NSString stringWithFormat:@"%i",[[servicesArray objectAtIndex:indexPath.row]servicePrice]];
        //cell.serviceDescriptionTxtView.text=[NSString stringWithFormat:@"%@",[[servicesArray objectAtIndex:indexPath.row]serviceDescription]];
        //        __block UIImage *MyPicture = [[UIImage alloc]init];
        //        PFFile *imageFile = [[servicesArray objectAtIndex:indexPath.row]serviceImage];
        //        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        //            if (!error) {
        //                MyPicture = [UIImage imageWithData:data];
        //                cell.serviceImg.image = MyPicture;
        //            }
        //        }];;
        //    }
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    temparray=[[NSMutableArray alloc]init];
    if ([segue.identifier isEqualToString:@"Service"]) {
        ServicesListViewController * servicedetail=(ServicesListViewController*)segue.destinationViewController;
        //NSIndexPath indexPath = [self.servicesTableView indexPathForSelectedRow];
       // selectedCategory=[[servicesArray objectAtIndex:indexPath.row]serviceType];
        for(int i=0;i<servicesArray.count;i++)
        {
            if([selectedCategory isEqualToString:[[servicesArray objectAtIndex:i]serviceType]])
            {
                [temparray addObject:[servicesArray objectAtIndex:i]];
            }
            
        }
        servicedetail.selectedCategory=selectedCategory;
        servicedetail.services=temparray;
        
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedCategory=[[otherServicesArray objectAtIndex:indexPath.row]serviceType];
   [self performSegueWithIdentifier:@"Service" sender:self];
}
- (void)setScreenState:(BOOL)state{
    (!state)?[SVProgressHUD show]:[SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:state];
    UIBarButtonItem *leftbutton = self.navigationItem.leftBarButtonItem;
    leftbutton.enabled = state;
}



@end
