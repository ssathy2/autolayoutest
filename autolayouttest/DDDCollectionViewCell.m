//
//  DDDCollectionViewCell.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 03/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDCollectionViewCell.h"

@interface DDDCollectionViewCell()
@property (strong, nonatomic) id model;
@end

@implementation DDDCollectionViewCell
- (void)prepareForReuse
{
	[super prepareForReuse];
}

- (void)updateWithModel:(id)model
{
	self.model = model;
	[self bindModelToUI];
}

- (void)bindModelToUI
{
	
}

@end
