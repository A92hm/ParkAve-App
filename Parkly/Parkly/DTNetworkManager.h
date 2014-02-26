//
//  DTNetworkManager.h
//  Parkly
//
//  Created by CCEW on 2/25/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "DTDataManager.h"

@interface DTNetworkManager : AFHTTPSessionManager

+ (instancetype) sharedInstance;

- (void) authenticateUser:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) fetchAllUsers: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) fetchSpotsForLotWithId:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) fetchUserWithId:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
