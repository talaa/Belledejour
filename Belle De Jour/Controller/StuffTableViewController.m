//
//  StuffTableViewController.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/19/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "StuffTableViewController.h"
#import <Parse/Parse.h>
#import "SMBInternetConnectionIndicator.h"
#import "Constants.h"
#import "SVProgressHUD.h"
#import "Stuff.h"
#import "StuffCustomCell.h"
@interface StuffTableViewController ()
{
    NSMutableArray * stuffList;
    Stuff * stuff;
}


@end

@implementation StuffTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowInternetIndicator;
    [self performSelector:@selector(getStuffData)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)getStuffData
{
    [self setScreenState:NO];
    stuffList=[[NSMutableArray alloc]init];
    PFQuery * parseServicesList=[PFQuery queryWithClassName:@"Stuff"];
    
    //          servicesList=  [parseServicesList findObjects];
    [parseServicesList findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for(int i=0;i<objects.count;i++)
        {
            stuff=[[Stuff alloc]init];
            stuff.name=[[objects objectAtIndex:i ] objectForKey:@"Name"];
            stuff.title=[[objects objectAtIndex:i ] objectForKey:@"Title"];
            stuff._image=[[objects objectAtIndex:i ] objectForKey:@"Picture"];
            [stuffList addObject:stuff ];
        }
        [_stuffTableView reloadData];
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
    return stuffList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StuffCell";
    
    StuffCustomCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StuffCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    if(stuffList.count>0)
    {
        cell.stuffNameLbl.text=[NSString stringWithFormat:@"%@",[[stuffList objectAtIndex:indexPath.row]name]];
        cell.stuffTiltleLbl.text=[NSString stringWithFormat:@"%@",[[stuffList objectAtIndex:indexPath.row]title]];

        __block UIImage *MyPicture = [[UIImage alloc]init];
        PFFile *imageFile = [[stuffList objectAtIndex:indexPath.row]_image];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
            if (!error) {
                MyPicture = [UIImage imageWithData:data];
                cell.stuffProfileImg.image = MyPicture;
            }
        }];;
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}
- (void)setScreenState:(BOOL)state{
    (!state)?[SVProgressHUD show]:[SVProgressHUD dismiss];
    [self.view setUserInteractionEnabled:state];
    UIBarButtonItem *leftbutton = self.navigationItem.leftBarButtonItem;
    leftbutton.enabled = state;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
