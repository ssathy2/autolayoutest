//
//  DDDLocalSearchManager.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 29/04/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDLocalSearchManager.h"

#define DDDProcessingDispatchQueueIdentifier "com.dddlocationprocessing.queue"

@interface DDDLocalSearchManager()
@property (strong, nonatomic) NSMutableDictionary *uuidTohandlerDictionary;
@property (strong, nonatomic) NSMutableDictionary *uuidToSearchDictionary;
@property (strong, nonatomic) NSMutableDictionary *queryToSearchDictionary;
@property (strong, nonatomic) NSOperationQueue *processingQueue;

@property (strong, nonatomic) NSLock *mapLock;
@end

@implementation DDDLocalSearchManager

- (id)init
{
	self = [super init];
	if (self)
	{
		self.uuidTohandlerDictionary = [NSMutableDictionary new];
		self.uuidToSearchDictionary = [NSMutableDictionary new];
		self.queryToSearchDictionary = [NSMutableDictionary new];
		
		self.processingQueue = [[NSOperationQueue alloc] init];
		self.mapLock = [[NSLock alloc] init];
	}
	return self;
}

- (NSUUID*)localSearchWithQuery:(NSString *)query withRegion:(MKCoordinateRegion)region withHandler:(void (^)(NSArray *, NSError *))handler
{
	if (self.queryToSearchDictionary[query])
	{
		return nil;
	}
	
	MKLocalSearchRequest *localSearchRequest = [[MKLocalSearchRequest alloc] init];
	localSearchRequest.region = region;
	localSearchRequest.naturalLanguageQuery = query;
	
	MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:localSearchRequest];
	NSUUID *identifier = [NSUUID UUID];
	
	[self.uuidTohandlerDictionary setObject:handler forKey:identifier];
	[self.uuidToSearchDictionary setObject:handler forKey:identifier];
	
	[localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
		[self searchCompleted: identifier query:query];
		[self.processingQueue addOperation:[NSBlockOperation blockOperationWithBlock:^(void){
			handler(response.mapItems, error);
		}]];
	}];
	
	return identifier;
}

- (void)searchCompleted:(NSUUID *)identifier query:(NSString *)query
{
	[self.mapLock lock];
	[self.uuidTohandlerDictionary removeObjectForKey:identifier];
	[self.uuidToSearchDictionary removeObjectForKey:identifier];
	[self.queryToSearchDictionary removeObjectForKey:query];
	[self.mapLock unlock];
}

@end
