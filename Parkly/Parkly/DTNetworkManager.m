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

#pragma mark - PUT

//PUT-> 1 Parameter
- (void) putTo:(NSString*)toWhere parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self genericPut:toWhere parameters:parameters success:success failure:failure];
}

//PUT-> 2 Parameters
- (void) putTo:(NSString*)toWhere what:(NSString*)whatYouWant parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@", toWhere, whatYouWant];
    [self genericPut:string parameters:parameters success:success failure:failure];
}

//PUT-> 3 Parameters
- (void) putTo:(NSString*)toWhere who:(NSString*)whoYouWantItFrom what:(NSString*)whatYouWant parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@/%@", toWhere, whoYouWantItFrom, whatYouWant];
    [self genericPut:string parameters:parameters success:success failure:failure];
}

//PUT-> 4 Parameters
- (void) putTo:(NSString*)toWhere who:(NSString*)whoYouWantItFrom what:(NSString*)whatYouWant which:(NSString*)whichOne parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@/%@/%@", toWhere, whoYouWantItFrom, whatYouWant, whichOne];
    [self genericPut:string parameters:parameters success:success failure:failure];
}


#pragma mark - DELETE

//DELETE-> 1 Parameter
- (void) deleteFrom:(NSString*)fromWhere parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    [self genericDelete:fromWhere parameters:parameters success:success failure:failure];
}

//DELETE-> 2 Parameters
- (void) deleteFrom:(NSString*)fromWhere what:(NSString*)whatYouWant parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@", fromWhere, whatYouWant];
    [self genericDelete:string parameters:parameters success:success failure:failure];
}

//DELETE-> 3 Parameters
- (void) deleteFrom:(NSString*)fromWhere who:(NSString*)whoYouWantItFrom what:(NSString*)whatYouWant parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@/%@", fromWhere, whoYouWantItFrom, whatYouWant];
    [self genericDelete:string parameters:parameters success:success failure:failure];
}

//DELETE-> 4 Parameters
- (void) deleteFrom:(NSString*)fromWhere who:(NSString*)whoYouWantItFrom what:(NSString*)whatYouWant which:(NSString*)whichOne parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //build an API call string
    NSString* string = [NSString stringWithFormat:@"%@/%@/%@/%@", fromWhere, whoYouWantItFrom, whatYouWant, whichOne];
    [self genericDelete:string parameters:parameters success:success failure:failure];
    
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

- (void) genericPut:(NSString*)pathString parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self PUT:pathString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

- (void) genericDelete:(NSString*)pathString parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self DELETE:pathString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, error);
    }];
}

@end
