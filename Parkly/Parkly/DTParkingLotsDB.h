//
//  FMDBDataAccess.h
//  Chanda
//
//  Created by Mohammad Azam on 10/25/11.
//  Copyright (c) 2011 HighOnCoding. All rights reserved.
//

#import "FMDatabase.h" 
#import "FMResultSet.h" 
#import "DTParkingLot.h"

#define DATABASE_NAME @"parkinglot"

@interface DTParkingLotsDB : NSObject

+ (instancetype) sharedInstance;

-(NSMutableArray *) getParkingLots;
-(BOOL) insertParkingLot:(DTParkingLot *) lot;
-(BOOL) updateParkingLot:(DTParkingLot *) lot;

@end