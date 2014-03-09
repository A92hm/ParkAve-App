//
//  FMDBDataAccess.m
//  Chanda
//
//  Created by Mohammad Azam on 10/25/11.
//  Copyright (c) 2011 HighOnCoding. All rights reserved.
//

#import "DTParkingLotsDB.h"

@implementation DTParkingLotsDB
{
    NSMutableArray *_parkingLots;
    NSString *databasePath;
}

+ (instancetype)sharedInstance {
    static DTParkingLotsDB *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

-(id)init
{
    self = [super init];

    if(self)
    {
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDir = [documentPaths objectAtIndex:0];
    
        databasePath = [documentDir stringByAppendingPathComponent:DATABASE_NAME];
    }
    
    return self;
}

-(BOOL) updateParkingLot:(DTParkingLot *) lot
{
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    
    [db open];
    
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE parkinglots SET user_name = '%@', distance = '%f', average_rating = '%f', average_price = '%f' where user_id = %i", lot.userName, lot.distance, lot.averageRating, lot.averagePrice, lot.userID]];
    
    [db close];
    
    return success; 
}

-(BOOL) insertParkingLot:(DTParkingLot *) lot
{
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    
    [db open];
    
    BOOL success = [db executeUpdate:@"INSERT INTO parkinglots (user_name, distance, average_rating, average_price) VALUES (?,?,?,?);", lot.userName, lot.distance, lot.averageRating, lot.averagePrice, nil];
    
    [db close];
    
    return success; 
    
    return YES; 
}

-(NSMutableArray *) getParkingLots
{
    //
    if(_parkingLots) return _parkingLots;
    
    _parkingLots = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];

    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM parkinglot"];
    
    while([results next]) 
    {
        DTParkingLot *lot = [[DTParkingLot alloc] init];
        
        lot.userID = [results intForColumn:@"user_id"];
        lot.userName = [results stringForColumn:@"user_name"];
        lot.distance = [results doubleForColumn:@"distance"];
        lot.averageRating = [results doubleForColumn:@"average_rating"];
        lot.averagePrice = [results doubleForColumn:@"average_price"];
        
        [_parkingLots addObject:lot];
    }
    
    [db close];
  
    return _parkingLots;
}

@end