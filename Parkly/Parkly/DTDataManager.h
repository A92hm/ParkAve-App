//
//  DTDataManager.h
//  Parkly
//
//  Created by CCEW on 2/25/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTDataManager : NSObject

+ (instancetype) sharedInstance;

- (void) updateSpots:(NSArray*)spotArray withLotId:(NSString*)lotID;

@end
