//
//  DDDBaseViewController.h
//  autolayouttest
//
//  Created by Sidd Sathyam on 02/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDDViewModel.h"

@interface DDDViewController : UIViewController

// Set the viewmodel property to be able to pass on view models between vc's
@property (strong, nonatomic) DDDViewModel *viewModel;

// Subclasses implement this method to be able to bind properties of classes to resulting destination vc's of segues
- (NSDictionary *)segueIdentifierToContainerViewControllerMapping;
@end
