//
//  DDDMapViewModel.h
//  autolayouttest
//
//  Created by Sidd Sathyam on 01/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDViewModel.h"

@interface DDDMapViewModel : DDDViewModel
@property (nonatomic, readonly) NSArray		*mapSearchResults;
@property (nonatomic, readonly) NSArray		*mapAnnotations;
@property (nonatomic, readonly) CLLocation	*currentUserLocation;

- (void)localSearchWithQuery:(NSString *)query region:(MKCoordinateRegion)region;
@end

@protocol DDDMapViewListener <DDDViewModelListener>
- (void)viewModel:(DDDMapViewModel *)viewModel didUpdateSearchResults:(NSArray *)searchResults;
- (void)viewModel:(DDDMapViewModel *)viewModel didUpdateMapAnnotations:(NSArray *)mapAnnotations;
- (void)viewModel:(DDDMapViewModel *)viewModel didUpdateCurrentUserLocation:(CLLocation *)currentUserLocation;
@end