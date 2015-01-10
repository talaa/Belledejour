//
//  FaceBookFeedsTableViewController.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/17/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "FaceBookFeedsTableViewController.h"
#import "Constants.h"
#import "FacebookFeeds.h"
#import "FeedsCustomCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
@interface FaceBookFeedsTableViewController ()
{
    NSArray * data;
}

@end

@implementation FaceBookFeedsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowInternetIndicator;
    data=[[NSArray alloc]init];
    //[FacebookFeeds parseFacebookFeeds];
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getFacebookFeeds:) name:@"FeedsRecieved" object:nil];
     //   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(feedsTimedOut:) name:@"FeedsTimeOut" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)feedsTimedOut:(NSNotification *)note
{
   [[NSNotificationCenter defaultCenter]removeObserver:self name:@"FeedsTimeOut" object:nil];
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Internal Error"delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}
-(void)getFacebookFeeds:(NSNotification *)note
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"FeedsRecieved" object:nil];
    NSDictionary * feedsDic=[note userInfo];
    
    data=[feedsDic objectForKey:@"data"];
    [self.feedsTableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(data.count>0)
        return data.count;
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FeedsCell";

    FeedsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedsCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[FeedsCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    if(data.count>0)
    {
        cell.feedTxtView.text=[[data objectAtIndex:indexPath.row]objectForKey:@"message"];
    
        
        __block UIActivityIndicatorView *activityIndicator;
        __weak UIImageView *weakImageView = cell.feedImageView;
        [cell.feedImageView sd_setImageWithURL:[NSURL URLWithString:[[data objectAtIndex:indexPath.row]objectForKey:@"picture"]]
                          placeholderImage:nil
                                   options:SDWebImageProgressiveDownload
                                  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                      if (!activityIndicator) {
                                          [weakImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]];
                                          activityIndicator.center = weakImageView.center;
                                          [activityIndicator startAnimating];
                                      }
                                  }
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     [activityIndicator removeFromSuperview];
                                     activityIndicator = nil;
                                 }];
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
