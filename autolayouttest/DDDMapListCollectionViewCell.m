//
//  DDDMapListCollectionViewCell.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 03/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDMapListCollectionViewCell.h"

@interface DDDMapListCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) MKMapItem		 *mapItemModel;
@end

@implementation DDDMapListCollectionViewCell
- (void)updateWithModel:(id)model
{
	[super updateWithModel:model];
	self.mapItemModel = (MKMapItem *)model;
	[self bindModelToUI];
}

- (void)bindModelToUI
{
	self.nameLabel.text			= self.mapItemModel.name;
	self.phoneNumberLabel.text	= self.mapItemModel.phoneNumber;
}
@end
