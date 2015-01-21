//
//  ServiceTableViewCell.m
//  Belle De Jour
//
//  Created by Nada Gamal on 12/1/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import "ServiceTableViewCell.h"

@implementation ServiceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}
-(void)drawRect:(CGRect)rect
{
    [self setBorder:_serviceImg];
 //self.serviceImg.contentMode = UIViewContentModeScaleAspectFit;
    
    
}
-(void)setBorder:(UIView*)view
{
    // border radius
    [view.layer setCornerRadius:10.0f];
    
    // border
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:1.5f];
    
    // drop shadow
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.8];
    [view.layer setShadowRadius:3.0];
    [view.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
