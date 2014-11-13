//
//  CustomCell.h
//  NavCtrl
//
//  Created by Aditya Narayan on 11/12/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell


@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *stockPriceLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImageView;

@end
