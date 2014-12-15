//
//  OffersCustomCell.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/11/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffersCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *offerImage;
@property (weak, nonatomic) IBOutlet UILabel *OfferNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *offerPriceLbl;
@property (weak, nonatomic) IBOutlet UIButton *bookBtn;

@end
