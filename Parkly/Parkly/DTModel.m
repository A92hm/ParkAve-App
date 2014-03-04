//
//  DTModel.m
//  Parkly
//
//  Created by CCEW on 2/24/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTModel.h"
#import "DTUser.h"
#import "DTParkingSpot.h"

@interface DTModel ()

@property (weak, nonatomic) DTDataManager* dataManager;
@property (weak, nonatomic) DTNetworkManager* networkManager;

- (NSArray*) parseJSON:(id)json toArrayOfClass:(__unsafe_unretained Class)theClass;

@end

@implementation DTModel

+ (instancetype)sharedInstance {
    //  Static local predicate must be initialized to 0
    static DTModel *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        
        // Do any other initialisation stuff here
        sharedInstance.dataManager = [DTDataManager sharedInstance];
        sharedInstance.networkManager = [DTNetworkManager sharedInstance];
    });
    return sharedInstance;
}

#pragma mark - Network Calls

- (void) authenticateUser:(NSString*)email withPassword:(NSString*)password success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSDictionary* parameters = @{@"email": email,
                                 @"password": password};
    
    [self.networkManager postTo:@"users" what:@"session" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if([[responseObject valueForKey:@"err"] isEqualToString:@"nomatch"]) {
            responseObject = @"error";
        } else {
            [[[self dataManager] currentUser] setValuesForKeysWithDictionary:responseObject];
        }
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (void) getAllUsers: (void (^)(NSURLSessionDataTask *task, NSArray* allUsers))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self.networkManager getFrom:@"users" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, [self parseJSON:responseObject toArrayOfClass:[DTUser class]]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (void) getSpotsForLotWithId:(NSString*)lotID success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //0. check if we already have the spots in memory
    //1. create parameters dictionary
    //2. call network manager
    //3.1   if success, parse spots into DTParkingSpot array
    //      update data manager
    //3.2   if failure, return error
    
    //0
    
    //1
    //NSDictionary* parameters = [NSDictionary dictionaryWithObject:lotID forKey:@"_id"];
    
    //2
    [self.networkManager getFrom:@"lots" who:lotID what:@"spots" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //if success, first parse JSON into objects
        NSArray* spotArray = [self parseJSON:responseObject toArrayOfClass:[DTParkingSpot class]];
        //update the dataManager
        [self.dataManager updateSpots:spotArray withLotId:lotID];
        
        //do whatever the user wants with the array of spots
        success(task, spotArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //bubble up the error
        failure(task, error);
    }];
}

- (void) getUserWithId:(NSString*)userID success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //NSDictionary* parameters = [NSDictionary dictionaryWithObject:userID forKey:@"_id"];
    
    //2

    [self.networkManager getFrom:@"users" what:userID parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //if success, first parse JSON into objects
        NSArray* spotArray = [self parseJSON:responseObject toArrayOfClass:[DTParkingSpot class]];
        //update the dataManager
        //[self.dataManager updateSpots:spotArray withLotId:userID];
        
        //do whatever the user wants with the array of spots
        success(task, spotArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (DTUser*) currentUser {
    return [self.dataManager currentUser];
}

#pragma mark - Helper Methods

- (NSArray*) parseJSON:(id)json toArrayOfClass:(__unsafe_unretained Class)theClass {
    NSArray* array = json;
    NSMutableArray* newArray = [[NSMutableArray alloc] init];
    for (NSDictionary* item in array) {
        id newItem = [[theClass alloc] init];
        [newItem setValuesForKeysWithDictionary:item];
        [newArray insertObject:newItem atIndex:[newArray count]];
    }
    return [newArray copy];
}

@end