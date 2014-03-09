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
    if(self = [super init])
    {
        [self initializeDatabase];
    }
    return self;
}

-(void)initializeDatabase
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"DTParkingLots" ofType:@"db"];
    databasePath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"DTParkingLots.db"]];
    
    if (![fm fileExistsAtPath:databasePath]) [fm copyItemAtPath:templatePath toPath:databasePath error:nil];
}

-(BOOL) updateParkingLot:(DTParkingLot *) lot
{
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    
    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET user_name = '%@', distance = '%@', average_rating = '%@', average_price = '%@' where user_id = %ld", DATABASE_NAME, lot.user_id, lot.distance, lot.averageRating, lot.averagePrice, (long)lot._id]];
    
    [db close];
    
    return success; 
}

-(BOOL) insertParkingLot:(DTParkingLot *) lot
{
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];

    [db open];

    NSString *sqlCommand = [NSString stringWithFormat:@"INSERT INTO %@ (user_name, distance, average_rating, average_price) VALUES (?,?,?,?);", DATABASE_NAME];
    BOOL success = [db executeUpdate:sqlCommand, lot.user_id, lot.distance, lot.averageRating, lot.averagePrice, nil];
    
    NSLog(@"%d", [db lastErrorCode]);
    
    if(success) [_parkingLots addObject:lot];
    
    [db close];
    
    return success;
}

-(NSMutableArray *) getParkingLots
{
    //
    if(_parkingLots) return _parkingLots;
    
    _parkingLots = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];

    [db open];
    
    FMResultSet *results = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@", DATABASE_NAME]];
    
    while([results next]) 
    {
        DTParkingLot *lot = [[DTParkingLot alloc] init];
        
        lot._id = [results intForColumn:@"user_id"];
        lot.user_id = [results stringForColumn:@"user_name"];
        lot.distance = [NSNumber numberWithDouble:[results doubleForColumn:@"distance"]];
        lot.averageRating = [NSNumber numberWithDouble:[results doubleForColumn:@"average_rating"]];
        lot.averagePrice = [NSNumber numberWithDouble:[results doubleForColumn:@"average_price"]];;
        
        [_parkingLots addObject:lot];
    }
    
    [db close];
  
    return _parkingLots;
}

@end