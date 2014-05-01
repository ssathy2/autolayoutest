//
//  DDDLocalSearchManager.h
//  autolayouttest
//
//  Created by Sidd Sathyam on 29/04/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDDLocalSearchManager : NSObject

- (NSUUID*)localSearchWithQuery:(NSString *)query withRegion:(MKCoordinateRegion)region withHandler:(void (^)(NSArray *results, NSError *error))handler;
@end
