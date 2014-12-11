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
@interface OffersTableViewController ()
{
    NSMutableArray * offers;
    Offer * offer;

}

@end

@implementation OffersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
                    }
                }];;

    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
