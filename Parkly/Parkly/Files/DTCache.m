//
//  DTCache.m
//  Park Ave
//
//  Created by Shelby Vanhooser on 3/22/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTCache.h"


@interface DTCache ()

@property (strong, nonatomic) NSMutableDictionary *imageCache;
@property (strong, nonatomic) NSMutableDictionary *lotsCache;
@property (strong, nonatomic) NSMutableDictionary *spotsCache;
@property (strong, nonatomic) NSMutableDictionary *reviewsCache;
@property (strong, nonatomic) NSMutableDictionary *carsCache;
@property (strong, nonatomic) NSString *ALL_LOTS_KEY;

@end

@implementation DTCache

+ (instancetype)sharedInstance
{
  static DTCache *sharedInstance = nil;
  static dispatch_once_t onceToken = 0;
  
  dispatch_once(&onceToken, ^{
    sharedInstance = [[[self class] alloc] init];
    sharedInstance.lotsCache = [[NSMutableDictionary alloc] init];
    sharedInstance.spotsCache = [[NSMutableDictionary alloc] init];
    sharedInstance.reviewsCache = [[NSMutableDictionary alloc] init];
    sharedInstance.imageCache = [[NSMutableDictionary alloc] init];
    sharedInstance.ALL_LOTS_KEY = @"GET_ALL_LOTS";
  });
  
  return sharedInstance;
}


#pragma mark - Checking methods

-(BOOL)hasImageForLot:(DTParkingLot *)theLot
{
  return [self.imageCache objectForKey:theLot._id] != nil;
}

-(BOOL)hasSpotsForLot:(DTParkingLot*)theLot
{
  return [self.spotsCache objectForKey:theLot._id] != nil;
}

-(BOOL)hasLot:(DTParkingLot*)theLot
{
  return [((NSArray *) [self.lotsCache objectForKey:self.ALL_LOTS_KEY]) containsObject:theLot];
}

-(BOOL)hasReviewsForUser:(DTUser*)theUser
{
  return [self.reviewsCache objectForKey:theUser._id] != nil;
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

-(void)addImage:(UIImage *)image forLot:(DTParkingLot *)theLot
{
  if(image){
    [self.imageCache setObject:image forKey:theLot._id];
  }
}

-(void)addLots:(NSArray *)theLots
{
  if(theLots){
    [self.lotsCache setObject:theLots forKey:self.ALL_LOTS_KEY];
  }
}

-(void)addSpots:(NSArray*)theSpots forLot:(DTParkingLot*)theLot
{
  if(theSpots && theLot){
    [self.spotsCache setObject:theSpots forKey:theLot._id];
  }
}

-(void)addReviews:(NSArray*)theReviews forUser:(DTUser*)theUser
{
  if(theReviews){
    [self.reviewsCache setObject:theReviews forKey:theUser._id];
  }
}

-(void)addCars:(NSArray *)theCars forUser:(DTUser *)theUser
{
  [self.carsCache setObject:theCars forKey:theUser._id];
}


#pragma mark - Fetching methods

-(UIImage*)imageForLot:(DTParkingLot *)theLot
{
  return [self.imageCache objectForKey:theLot._id];
}

-(NSArray*)spotsForLot:(DTParkingLot*)theLot
{
  return [self.spotsCache objectForKey:theLot._id];
}

-(NSArray*)allLots
{
  return [self.lotsCache objectForKey:self.ALL_LOTS_KEY];
}

-(NSArray*)reviewsForUser:(DTUser*)theUser
{
  return [self.reviewsCache objectForKey:theUser._id];
}

-(NSArray*)carsForUser:(DTUser *)theUser
{
    return [self.carsCache objectForKey:theUser._id];
}


#pragma mark - Removal methods

-(void)removeImageForLot:(DTParkingLot *)theLot
{
  [self.imageCache removeObjectForKey:theLot._id];
}

-(void)removeSpotsForLot:(DTParkingLot *)theLot
{
  [self.spotsCache removeObjectForKey:theLot._id];
}

-(void)removeLot:(DTParkingLot *)theLot
{
  [self removeSpotsForLot:theLot];
  [self.lotsCache removeObjectForKey:theLot._id];
}

-(void)removeReviewsForUser:(DTUser *)theUser
{
  [self.reviewsCache removeObjectForKey:theUser._id];
}

-(void)removeCarsForUser:(DTUser*)theUser;
{
  [self.carsCache removeObjectForKey:theUser._id];
}

-(void)removeAllImages
{
  [self.imageCache removeAllObjects];
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
  [self.imageCache removeAllObjects];
  NSLog(@"Scrubbed the caches");
}

@end
