//
//  ServiceCollectionViewCell.h
//  Belle De Jour
//
//  Created by Nada Gamal on 12/14/14.
//  Copyright (c) 2014 SpringMoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *serviceImage;
@property (weak, nonatomic) IBOutlet UILabel *serviceName;

@end
