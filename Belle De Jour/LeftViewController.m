//
//  LeftViewController.m
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/17/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "LeftViewController.h"
#import "UIViewController+RESideMenu.h"
#import "HomeViewController.h"
#import "ServicesTableViewController.h"
#import "OffersTableViewController.h"
#import "SharedManager.h"
#import "FaceBookFeedsTableViewController.h"



@interface LeftViewController ()
@property (nonatomic)NSArray *titles;
@property (nonatomic)NSArray *images;
@end

@implementation LeftViewController
@synthesize titles,images;
- (void)viewDidLoad
{
    [super viewDidLoad];
    if([[SharedManager sharedManager]userProfile].name==nil)
    {
    self.tableView = ({
        titles = @[@"Home", @"Services",@"Offers", @"About",@"Stuff", @"Settings",@"Contact Us", @"Log In"];
        images = @[@"IconHome", @"IconCalendar",@"IconEmpty",@"IconEmpty", @"IconProfile", @"IconSettings", @"IconEmpty",@"IconEmpty"];
    
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * [titles count]) / 2.0f, self.view.frame.size.width, 54 * [titles count]) style:UITableViewStylePlain];
         //UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 8) / 2.0f, self.view.frame.size.width, 54 * 8) style:UITableViewStylePlain];
        
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    }
    else
    {
        self.tableView = ({
            titles = @[[[SharedManager sharedManager]userProfile].name, @"Home", @"Services",@"Offers", @"About",@"Stuff", @"Settings",@"Contact Us", @"Log out"];
            images = @[@"IconHome",@"IconHome", @"IconCalendar",@"IconEmpty",@"IconEmpty", @"IconProfile", @"IconSettings", @"IconEmpty",@"IconEmpty"];
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * [titles count]) / 2.0f, self.view.frame.size.width, 54 * [titles count]) style:UITableViewStylePlain];
            //UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 8) / 2.0f, self.view.frame.size.width, 54 * 8) style:UITableViewStylePlain];
            
            tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.opaque = NO;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.backgroundView = nil;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.bounces = NO;
            tableView.scrollsToTop = NO;
            tableView;
        });
        
    }
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([[SharedManager sharedManager]userProfile].name==nil)
    {
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController1"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Servicescontroller"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"OffersViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FacebookFeeds"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"StuffViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 5:
        {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In First"
                                                                message:@"Please Login First !!"
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Dismiss", nil];
                [alert show];
        }
            break;
        case 6:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 7:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;

        default:
            break;
    }
    }
    else
    {
        switch (indexPath.row) {
            case 1:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController1"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 2:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Servicescontroller"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 3:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"OffersViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 4:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"FacebookFeeds"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 5:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"StuffViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 6:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 7:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
            case 8:
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
       cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}


@end
