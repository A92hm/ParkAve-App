//
//  DTCache.m
//  Park Ave
//
//  Created by Shelby Vanhooser on 3/22/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTCache.h"


@interface DTCache ()

@property NSCache *lotsCache;
@property NSCache *spotsCache;
@property NSCache *reviewsCache;
@property NSCache *carsCache;
@property NSString *ALL_LOTS_KEY;

@end

@implementation DTCache

+ (instancetype)sharedInstance
{
  static DTCache *sharedInstance = nil;
  static dispatch_once_t onceToken = 0;
  
  dispatch_once(&onceToken, ^{
    sharedInstance = [[[self class] alloc] init];
    sharedInstance.lotsCache = [[NSCache alloc] init];
    sharedInstance.spotsCache = [[NSCache alloc] init];
    sharedInstance.reviewsCache = [[NSCache alloc] init];
    sharedInstance.reviewsCache = [[NSCache alloc] init];
    sharedInstance.ALL_LOTS_KEY = @"GET_ALL_LOTS";
  });
  
  return sharedInstance;
}


#pragma mark - Checking methods

-(BOOL)hasSpotsForLot:(DTParkingLot*)theLot
{
  return [self.spotsCache objectForKey:theLot] != nil;
}

-(BOOL)hasLot:(DTParkingLot*)theLot
{
  return [((NSArray *) [self.lotsCache objectForKey:self.ALL_LOTS_KEY]) containsObject:theLot];
}

-(BOOL)hasReviewsForUser:(DTUser*)theUser
{
  return [self.reviewsCache objectForKey:theUser] != nil;
}

-(BOOL)hasCarsForUser:(DTUser *)theUser
{
    return [self.carsCache objectForKey:theUser] != nil;
}

-(BOOL)hasLots
{
  return [self.lotsCache objectForKey:self.ALL_LOTS_KEY] != nil;
}

#pragma mark - Adding methods

-(void)addLots:(NSArray *)theLots
{
  if(theLots){
    [self.lotsCache setObject:theLots forKey:self.ALL_LOTS_KEY];
  }
}

-(void)addSpots:(NSArray*)theSpots forLot:(DTParkingLot*)theLot
{
  [self.spotsCache setObject:theSpots forKey:theLot];
}

-(void)addReviews:(NSArray*)theReviews forUser:(DTUser*)theUser
{
  [self.reviewsCache setObject:theReviews forKey:theUser];
}

-(void)addCars:(NSArray *)theCars forUser:(DTUser *)theUser
{
    [self.carsCache setObject:theCars forKey:theUser];
}


#pragma mark - Fetching methods

-(NSArray*)spotsForLot:(DTParkingLot*)theLot
{
  return [self.spotsCache objectForKey:theLot];
}

-(NSArray*)allLots
{
  return [self.lotsCache objectForKey:self.ALL_LOTS_KEY];
}

-(NSArray*)reviewsForUser:(DTUser*)theUser
{
  return [self.reviewsCache objectForKey:theUser];
}

-(NSArray*)carsForUser:(DTUser *)theUser
{
    return [self.carsCache objectForKey:theUser];
}


#pragma mark - Removal methods

-(void)removeSpotsForLot:(DTParkingLot *)theLot
{
  [self.spotsCache removeObjectForKey:theLot];
}

-(void)removeLot:(DTParkingLot *)theLot
{
  [self removeSpotsForLot:theLot];
  [self.lotsCache removeObjectForKey:theLot];
}

-(void)removeReviewsForUser:(DTUser *)theUser
{
  [self.reviewsCache removeObjectForKey:theUser];
}

-(void)removeCarsForUser:(DTUser*)theUser;
{
  [self.carsCache removeObjectForKey:theUser];
}

-(void)removeAllLots
{
  [self.lotsCache removeAllObjects];
}

-(void)removeAllSpots
{
  [self.spotsCache removeAllObjects];
}

-(void)removeAllCars
{
  [self.carsCache removeAllObjects];
}

-(void)removeAll
{
  [self.reviewsCache removeAllObjects];
  [self.lotsCache removeAllObjects];
  [self.spotsCache removeAllObjects];
  [self.carsCache removeAllObjects];
  NSLog(@"Scrubbed the caches");
}

@end
