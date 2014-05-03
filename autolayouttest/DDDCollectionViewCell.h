//
//  DDDCollectionViewCell.h
//  autolayouttest
//
//  Created by Sidd Sathyam on 03/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDDCollectionViewCell : UICollectionViewCell

// Every collection view cell has a model that can be updated with updateWithModel:
@property (nonatomic, readonly) id model;

// Override this method in subclasses to bind the param model's properties to the UI of the cell
- (void)updateWithModel:(id)model;
@end
