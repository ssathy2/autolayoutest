//
//  DDDViewModel.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 01/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDViewModel.h"

@interface DDDViewModel()
@property (strong, nonatomic) NSHashTable *listeners;
@end
@implementation DDDViewModel
- (id)init
{
	self = [super init];
	if (self)
	{
		self.listeners = [NSHashTable weakObjectsHashTable];
	}
	return self;
}

- (void)initialRegistrationForListener
{
	for (SEL sel in self.)
}

- (void)registerListener:(id<DDDViewModelListener>)listener
{
	if (![self.listeners containsObject:listener])
	{
		[self.listeners addObject:listener];
	}
}

- (void)deregisterListener:(id<DDDViewModelListener>)listener
{
	if (![self.listeners containsObject:listener])
	{
		[self.listeners removeObject:listener];
	}
}

- (void)callDelegateListenersWithSelector:(SEL)selector
{
	[self callDelegateListenersWithSelector:selector withObject:nil];
}

- (void)callDelegateListenersWithSelector:(SEL)selector withObject:(id)object1
{
	for (id<DDDViewModelListener> listener in self.listeners)
	{
		if ([listener respondsToSelector:selector])
		{
			if (object1)
				[listener performSelector:selector withObject:self withObject:(object1)];
			else
				[listener performSelector:selector withObject:self];
		}
	}
}
@end
