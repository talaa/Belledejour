//
//  ServicesListViewController.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/10/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "ServicesListViewController.h"
#import "Service.h"
#import <Parse/Parse.h>
#import "ServiceListCustomCell.h"

@implementation ServicesListViewController
-(void)viewDidLoad
{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _services.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ServicesCellList";
    
    ServiceListCustomCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ServiceListCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    if(_services.count>0)
    {
        cell.serviceNameLbl.text=[[_services objectAtIndex:indexPath.row]serviceType];
        //  cell.serviceIDLbl.text=[NSString stringWithFormat:@"%i",[[servicesArray objectAtIndex:indexPath.row]serviceID]];
        // cell.servicePriceLbl.text=[NSString stringWithFormat:@"%i",[[servicesArray objectAtIndex:indexPath.row]servicePrice]];
        //cell.serviceDescriptionTxtView.text=[NSString stringWithFormat:@"%@",[[servicesArray objectAtIndex:indexPath.row]serviceDescription]];
               __block UIImage *MyPicture = [[UIImage alloc]init];
                PFFile *imageFile = [[_services objectAtIndex:indexPath.row]serviceImage];
               [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
                    if (!error) {
                       MyPicture = [UIImage imageWithData:data];
                     cell.serviceImage.image=MyPicture;
                   }
               }];;
    }
    
    return cell;
}

@end
