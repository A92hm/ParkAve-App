//
//  DTNetworkManager.m
//  Parkly
//
//  Created by CCEW on 2/25/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTNetworkManager.h"

@implementation DTNetworkManager

static NSString * const apiBaseURL = @"http://parking.alihm.net/api/";

+ (instancetype)sharedInstance {
    //  Static local predicate must be initialized to 0
    static DTNetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] initWithBaseURL:[NSURL URLWithString:apiBaseURL]];
        
        // Do any other initialisation stuff here
        sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
        sharedInstance.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
    }
    return self;
}

- (void) authenticateUser:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self POST:@"users/session" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (void) fetchSpotsForLotWithId:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self GET:@"spots/whatever" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //bubble up the error
        failure(task,error);
    }];
}

- (void) fetchAllUsers: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self GET:@"users" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (void) fetchUserWithId:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //[self GET:@"users/"]
}


@end
