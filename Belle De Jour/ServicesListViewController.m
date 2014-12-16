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
        [self.servicesCollectionView deselectItemAtIndexPath:cellIndex animated:NO];

        
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    cellIndex=indexPath;
    [self performSegueWithIdentifier:@"serviceDetails" sender:self];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _services.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceCollectionCell" forIndexPath:indexPath];
    if(_services.count>0)
    {
        cell.serviceName.text=[(Service *)[_services objectAtIndex:indexPath.row]serviceName];
        cell.serviceCollectionPrice.text=[NSString stringWithFormat:@"%i Dirham",[(Service *)[_services objectAtIndex:indexPath.row]servicePrice]];
        __block UIImage *MyPicture = [[UIImage alloc]init];
        PFFile *imageFile = [(Service *)[_services objectAtIndex:indexPath.row]serviceImage];
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
