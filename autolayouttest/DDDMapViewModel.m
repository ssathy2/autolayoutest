//
//  DDDMapViewModel.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 01/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDMapViewModel.h"
#import "DDDLocalSearchManager.h"

@interface DDDMapViewModel()<CLLocationManagerDelegate>
@property (strong, nonatomic) NSArray				*mapSearchResults;
@property (strong, nonatomic) NSArray				*mapAnnotations;
@property (strong, nonatomic) DDDLocalSearchManager *searchManager;
@property (strong, nonatomic) CLLocation			*currentUserLocation;
@property (strong, nonatomic) CLLocationManager		*locationManager;
@end

@implementation DDDMapViewModel

- (id)init
{
	self = [super init];
	if (self)
	{
		self.searchManager = [DDDLocalSearchManager new];
		[self setupLocationManager];
	}
	return self;
}

- (void)setupLocationManager
{
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[self.locationManager startUpdatingLocation];
}

- (void)localSearchWithQuery:(NSString *)query region:(MKCoordinateRegion) region
{
	[self.searchManager localSearchWithQuery:query withRegion:region withHandler:^(NSArray *results, NSError *error) {
		self.mapSearchResults = results;
		[self callDelegateListenersWithSelector:@selector(viewModel:didUpdateSearchResults:) withObject:results];
		[self convertLocalSearchResultsIntoMapAnnotations];
	}];
}

- (void)convertLocalSearchResultsIntoMapAnnotations
{
	NSMutableArray *annotations = [NSMutableArray array];
	for (MKMapItem *item in self.mapSearchResults)
	{
		MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
		annotation.coordinate = item.placemark.coordinate;
		annotation.title = item.name;
		[annotations addObject:annotation];
	}
	self.mapAnnotations = annotations;
	[self callDelegateListenersWithSelector:@selector(viewModel:didUpdateMapAnnotations:) withObject:self.mapAnnotations];
}

#pragma mark - CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
	self.currentUserLocation = [locations firstObject];
	[self callDelegateListenersWithSelector:@selector(viewModel:didUpdateCurrentUserLocation:) withObject:self.currentUserLocation];
}

@end
