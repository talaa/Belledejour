//
//  ServiceTableViewCell.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/1/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTableViewCell : UITableViewCell
@property(nonatomic) IBOutlet UILabel * servicePriceLbl;
@property(nonatomic) IBOutlet UIImageView * serviceImg;
@property(nonatomic) IBOutlet UILabel * serviceIDLbl;
@property(nonatomic)IBOutlet UITextView * serviceDescriptionTxtView;

@end
