//
//  DTNetworkManager.m
//  Parkly
//
//  Created by CCEW on 2/25/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTNetworkManager.h"

@implementation DTNetworkManager

static NSString * const apiBaseURL = @"http://dev.getparkave.com:3000/api/";

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

- (void) call:(NSString*)action one:(NSString*)one parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [self genericCall:action path:one parameters:parameters success:success failure:failure];
}

- (void) call:(NSString*)action one:(NSString*)one two:(NSString*)two parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString* path = [NSString stringWithFormat:@"%@/%@", one, two];
    
    [self genericCall:action path:path parameters:parameters success:success failure:failure];
}

- (void) call:(NSString*)action one:(NSString*)one two:(NSString*)two three:(NSString*)three parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
        NSString* path = [NSString stringWithFormat:@"%@/%@/%@", one, two, three];
    [self genericCall:action path:path parameters:parameters success:success failure:failure];
}

- (void) call:(NSString*)action one:(NSString*)one two:(NSString*)two three:(NSString*)three four:(NSString*)four parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
        NSString* path = [NSString stringWithFormat:@"%@/%@/%@/%@", one, two, three, four];
    [self genericCall:action path:path parameters:parameters success:success failure:failure];
}

- (void) call:(NSString*)action one:(NSString*)one two:(NSString*)two three:(NSString*)three four:(NSString*)four five:(NSString*)five parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString* path = [NSString stringWithFormat:@"%@/%@/%@/%@/%@", one, two, three, four, five];
    [self genericCall:action path:path parameters:parameters success:success failure:failure];
}

- (void) call:(NSString*)action one:(NSString*)one two:(NSString*)two three:(NSString*)three four:(NSString*)four five:(NSString*)five six:(NSString*)six parameters:(NSDictionary*)parameters success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString* path = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@", one, two, three, four, five, six];
    [self genericCall:action path:path parameters:parameters success:success failure:failure];
}

#pragma mark - Helper Methods

- (void) checkResponseStatus:(id)responseObject success:(void (^)(id responseObject))success failure: (void (^)(NSString* statusCode, NSString* description))failure {

    if([[responseObject allKeys] containsObject:@"err"]) {
        failure([responseObject objectForKey:@"err"], @"there was an error");
    } else {
        success(responseObject);
    }
    
    /*
    NSString *status = [responseObject valueForKey:@"status"];
    
    if (status == NULL) {
        status = [responseObject valueForKey:@"response"];
    }
    
    [[responseObject mutableCopy] removeObjectForKey:@"status"];
    
    if ([status isEqualToString:@"Success"]) {
        success(responseObject);
    } else {
        failure(status, @"There was an error.");
    }*/
}

- (void) genericCall:(NSString*)action path:(NSString*) path parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    if([action isEqualToString:@"get"]) {
        [self genericGet:path parameters:parameters success:success failure:failure];
    } else if ([action isEqualToString:@"post"]) {
        [self genericPost:path parameters:parameters success:success failure:failure];
    } else if ([action isEqualToString:@"put"]) {
        [self genericPut:path parameters:parameters success:success failure:failure];
    } else if ([action isEqualToString:@"delete"]) {
        [self genericDelete:path parameters:parameters success:success failure:failure];
    } else {
        NSLog(@"%@ isn't an action", action);
    }
}

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
