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


#pragma mark - GET

//GET-> 1 Parameter
- (void) getFrom:(NSString*)fromWhere parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self genericGet:fromWhere parameters:parameters success:success failure:failure];
}

//GET-> 2 Parameters
- (void) getFrom:(NSString*)fromWhere what:(NSString*)whatYouWant parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@", fromWhere, whatYouWant];
    [self genericGet:string parameters:parameters success:success failure:failure];
}

//GET-> 3 Parameters
- (void) getFrom:(NSString*)fromWhere who:(NSString*)whoYouWantItFrom what:(NSString*)whatYouWant parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@/%@", fromWhere, whoYouWantItFrom, whatYouWant];
    [self genericGet:string parameters:parameters success:success failure:failure];
}

//GET-> 4 Parameters
- (void) getFrom:(NSString*)fromWhere who:(NSString*)whoYouWantItFrom what:(NSString*)whatYouWant which:(NSString*)whichOne parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@/%@/%@", fromWhere, whoYouWantItFrom, whatYouWant, whichOne];
    [self genericGet:string parameters:parameters success:success failure:failure];
}

#pragma mark - POST

//POST-> 1 Parameter
- (void) postTo:(NSString*)toWhere parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self genericPost:toWhere parameters:parameters success:success failure:failure];
}

//POST-> 2 Parameters
- (void) postTo:(NSString*)toWhere what:(NSString*)whatYouWant parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@", toWhere, whatYouWant];
    [self genericPost:string parameters:parameters success:success failure:failure];
}

//POST-> 3 Parameters
- (void) postTo:(NSString*)toWhere who:(NSString*)whoYouWantItFrom what:(NSString*)whatYouWant parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@/%@", toWhere, whoYouWantItFrom, whatYouWant];
    [self genericPost:string parameters:parameters success:success failure:failure];
}

//POST-> 4 Parameters
- (void) postTo:(NSString*)toWhere who:(NSString*)whoYouWantItFrom what:(NSString*)whatYouWant which:(NSString*)whichOne parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@/%@/%@", toWhere, whoYouWantItFrom, whatYouWant, whichOne];
    [self genericPost:string parameters:parameters success:success failure:failure];
}

#pragma mark - Helper Methods

- (void) genericGet:(NSString*)pathString parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self GET:pathString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (void) genericPost:(NSString*)pathString parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self POST:pathString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

@end
