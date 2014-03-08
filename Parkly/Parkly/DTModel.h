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
#import "DTUser.h"
#import "DTParkingLot.h"
#import "DTParkingSpot.h"
#import "DTReview.h"
#import "DTCar.h"

@interface DTModel : NSObject

+ (instancetype) sharedInstance;

#pragma mark - Local User Session
- (void) loginUser:(DTUser*)user;
- (void) logoutUser;
- (BOOL) userIsLoggedIn;
- (BOOL) userHasAccount;

//most of these are not yet implemented

#pragma mark - Users

- (void) authenticateUser:(DTUser*)user success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getAllUsers: (void (^)(NSURLSessionDataTask *task, NSArray* allUsers))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getUserWithId:(NSString*)userID success: (void (^)(NSURLSessionDataTask *task, DTUser* user))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) createUser:(DTUser*)user success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) updateUser:(DTUser*)user success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) deleteUser:(DTUser*)user success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - Lots

- (void) getAllLots: (void (^)(NSURLSessionDataTask *task, NSArray* allLots))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getLot:(DTParkingLot*)lot success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) createLot:(DTParkingLot*)lot success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) updateLot:(DTParkingLot*)lot success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) deleteLot:(DTParkingLot*)lot success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getLotsNearLatitude:(CGFloat*)latitude andLongitude:(CGFloat*)longitude success:(void (^)(NSURLSessionDataTask *task, NSArray* allLots))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - Spots

- (void) getSpotsForLot:(DTParkingLot*)lot success: (void (^)(NSURLSessionDataTask *task, NSArray* spots))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getSpot:(DTParkingSpot*)spot success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) createSpot:(DTParkingSpot*)spot success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) updateSpot:(DTParkingSpot*)spot success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) deleteSpot:(DTParkingSpot*)spot success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - Cars

- (void) getCarsForUser:(DTUser*)user success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getCar:(DTCar*)car success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) createCar:(DTCar*)car success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) updateCar:(DTCar*)car success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) deleteCar:(DTCar*)car success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - Reviews

- (void) getAllReviews: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getReviewsForUser:(DTUser*)user success: (void (^)(NSURLSessionDataTask *task, NSArray* reviews))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) getReview:(DTReview*)review success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) createReview:(DTReview*)review success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) updateReview:(DTReview*)review success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void) deleteReview:(DTReview*)review success: (void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - Pseudo-properties

- (DTUser*) currentUser;

- (NSString*) defaultEmail;
- (NSString*) defaultPassword;
- (BOOL) defaultsExist;

#pragma mark - Sorting

- (NSArray*) sortLotsByRating:(NSArray*)array isAscending:(BOOL)isAscending;
- (NSArray*) sortLots:(NSMutableArray*)array byDistanceFromLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude isAscending:(BOOL)isDescending;
- (NSArray*) sortLotsByPrice:(NSArray*)array isAscending:(BOOL)isAscending;

#pragma mark - Helper Methods

- (NSArray*) parseJSON:(id)json toArrayOfClass:(__unsafe_unretained Class)theClass;

@end
