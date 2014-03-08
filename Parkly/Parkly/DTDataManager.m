//
//  DTDataManager.m
//  Parkly
//
//  Created by CCEW on 2/25/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTDataManager.h"

@implementation DTDataManager

+ (instancetype)sharedInstance {
    //  Static local predicate must be initialized to 0
    static DTDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        
        // Do any other initialisation stuff here
        sharedInstance.currentUser = nil;
        
        //sharedInstance.dataManager = [DTDataManager sharedInstance];
        //sharedInstance.networkManager = [DTNetworkManager sharedInstance];
    });
    return sharedInstance;
}

- (void) loginUser:(DTUser*)user {
    self.currentUser = user;
}

- (void) logoutUser {
#warning this needs to be different
    self.currentUser = nil;
}

- (void) updateSpots:(NSArray*)spotArray withLotId:(NSString*)lotID {
    
}

@end
