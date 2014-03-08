//
//  DTDataManager.h
//  Parkly
//
//  Created by CCEW on 2/25/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTUser.h"
#import "DTParkingLot.h"
#import "DTParkingSpot.h"
#import "DTReview.h"
#import "DTCar.h"

@interface DTDataManager : NSObject

+ (instancetype) sharedInstance;

@property(strong, nonatomic) DTUser* currentUser;

- (void) loginUser:(DTUser*)user;
- (void) logoutUser;

- (void) updateSpots:(NSArray*)spotArray withLotId:(NSString*)lotID;



@end
