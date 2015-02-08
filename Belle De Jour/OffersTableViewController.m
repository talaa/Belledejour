//
//  OffersTableViewController.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/17/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "OffersTableViewController.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"
#import "Offer.h"
#import "Constants.h"
#import "OffersCustomCell.h"
#import "ServiceDetails.h"
#import "BookingViewController.h"
@interface OffersTableViewController ()
{
    NSMutableArray * offers;
    Offer * offer;
    UIImage * serviceImg;

}

@end

@implementation OffersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    serviceImg=[[UIImage alloc]init];
    ShowInternetIndicator;
    [self performSelector:@selector(getOffers)];
}
- (void)setScreenState:(BOOL)state{
    (!state)?[SVProgressHUD show]:[SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:state];
    UIBarButtonItem *leftbutton = self.navigationItem.leftBarButtonItem;
    leftbutton.enabled = state;
}
-(void)getOffers
{
    [self setScreenState:NO];
    offers=[[NSMutableArray alloc]init];
    PFQuery * parseOffersList=[PFQuery queryWithClassName:@"Offers"];
    
    //          servicesList=  [parseServicesList findObjects];
    [parseOffersList findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for(int i=0;i<objects.count;i++)
        {
            offer=[[Offer alloc]init];
            offer.offerName=[[objects objectAtIndex:i ] objectForKey:@"Offer_ID"];
            offer.offerDescription=[[objects objectAtIndex:i ] objectForKey:@"Offer_Description"];
            offer.offerPrice=[[[objects objectAtIndex:i ] objectForKey:@"Offer_Price"]intValue];
            offer.loyaltyPoints=[[[objects objectAtIndex:i ] objectForKey:@"Offer_LoyaltyPoints"]intValue];
            offer.offerImage=[[objects objectAtIndex:i ] objectForKey:@"Offer_Picture"];
            [offers addObject:offer];
        }
        [_offersTableView reloadData];
        [self setScreenState:YES];
        
        
    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BookingViewController * bookingView=(BookingViewController*)segue.destinationViewController;
    NSIndexPath *indexPath = [self.offersTableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"OfferSelection"]) {
        ServiceDetails * servicedetail=(ServiceDetails*)segue.destinationViewController;
        NSIndexPath *indexPath = [self.offersTableView indexPathForSelectedRow];
        servicedetail.offer=(Offer*)[offers objectAtIndex:indexPath.row];
        servicedetail.navigationTitle=[[offers objectAtIndex:indexPath.row]offerName];
            }

   else if ([segue.identifier isEqualToString:@"Booking"]) {
        bookingView.serviceName=[[offers objectAtIndex:indexPath.row]offerName];
        bookingView.servicePrice=[[offers objectAtIndex:indexPath.row]offerPrice];
        bookingView.serviceImage =serviceImg;
        
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return offers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"offerCell";
    
   OffersCustomCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OffersCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    if(offers.count>0)
    {
        cell.OfferNameLbl.text=[NSString stringWithFormat:@"%@",[[offers objectAtIndex:indexPath.row]offerName]];
        cell.offerPriceLbl.text=[NSString stringWithFormat:@"%i Dirham",[[offers objectAtIndex:indexPath.row]offerPrice]];
                __block UIImage *MyPicture = [[UIImage alloc]init];
                PFFile *imageFile = [[offers objectAtIndex:indexPath.row]offerImage];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
                    if (!error) {
                        MyPicture = [UIImage imageWithData:data];
                        cell.offerImage.image = MyPicture;
                        serviceImg=MyPicture;
                    }
                }];;

    }
    return cell;
}





@end
