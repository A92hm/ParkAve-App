//
//  DTModel.h
//  Parkly
//
//  Created by CCEW on 2/24/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTDataManager.h"
#import "DTNetworkManager.h"

@interface DTModel : NSObject

+ (instancetype) sharedInstance;

- (void) authenticateUser:(NSString*)email withPassword:(NSString*)password success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getAllUsers: (void (^)(NSURLSessionDataTask *task, NSArray* allUsers))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getUserWithId:(NSString*)userID success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getSpotsForLotWithId:(NSString*)lotID success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (DTUser*) currentUser;


#pragma mark - Helper Methods

- (NSArray*) parseJSON:(id)json toArrayOfClass:(__unsafe_unretained Class)theClass;

@end
