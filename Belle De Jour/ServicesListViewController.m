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
#import "ServiceDetails.h"
#import "ServiceCollectionViewCell.h"
#import "ServiceTableViewCell.h"

@implementation ServicesListViewController
{
    NSIndexPath * cellIndex;
}
-(void)viewDidLoad
{
    self.navigationItemTitle.title=_selectedCategory;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"serviceDetails"]) {
        ServiceDetails * servicedetail=(ServiceDetails*)segue.destinationViewController;
       // NSIndexPath *indexPath = [self.servicesCollectionView indexPathForCell:(ServiceCollectionViewCell*)sender];
     //   NSArray *indexPaths = [self.servicesCollectionView indexPathsForSelectedItems];
       // NSIndexPath *indexPath = [indexPaths objectAtIndex:0];

        servicedetail.service=(Service*)[_services objectAtIndex:cellIndex.row];
        servicedetail.navigationTitle=[[_services objectAtIndex:cellIndex.row]serviceName];
       // servicedetail.serviceImage=(UIImageView*)[(Service *)[_services objectAtIndex:cellIndex.row]serviceImage];
        //[self.servicesCollectionView deselectItemAtIndexPath:cellIndex animated:NO];

        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cellIndex=indexPath;
    [self performSegueWithIdentifier:@"serviceDetails" sender:self];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _services.count;
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // ServiceTableViewCell *cell = [tableView dequeueReusableCellWithReuseIdentifier:@"ServiceTableViewCell" forIndexPath:indexPath];
    static NSString *CellIdentifier = @"ServiceTableViewCell";
    
    ServiceTableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }

    if(_services.count>0)
    {
        cell.serviceIDLbl.text=[(Service *)[_services objectAtIndex:indexPath.row]serviceName];
        cell.servicePriceLbl.text=[NSString stringWithFormat:@"%i AED",[(Service *)[_services objectAtIndex:indexPath.row]servicePrice]];
        
        cell.servicePriceLbl.backgroundColor=[UIColor colorWithRed:0.5159f green:0.8254f blue:0.3810 alpha:0.8631];
        cell.servicePriceLbl.textColor=[UIColor whiteColor];
        [cell.servicePriceLbl.layer setCornerRadius:10.0f];
        [cell.servicePriceLbl.layer setMasksToBounds:YES];
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"web-elements"]];
        __block UIImage *MyPicture = [[UIImage alloc]init];
        PFFile *imageFile = [(Service *)[_services objectAtIndex:indexPath.row]serviceImage];

        if(imageFile!=nil)
        {
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
            if (!error) {
                MyPicture = [UIImage imageWithData:data];
                cell.serviceImg.image=MyPicture;
            }
        }];;
        }
        else
            cell.serviceImg.image=nil;
    }
    
    return cell;
}

@end
