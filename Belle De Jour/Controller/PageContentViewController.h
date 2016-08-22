//
//  PageContentViewController.h
//  Belle De Jour
//
//  Created by Tamer Alaa on 11/18/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
