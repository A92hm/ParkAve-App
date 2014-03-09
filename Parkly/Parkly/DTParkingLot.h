//
//  DTParkingLot.h
//  Parkly
//
//  Created by Shelby Vanhooser on 2/21/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTParkingLot : NSObject

//These properties correspond to the email sent out declaring the data stored in the webserver.  The types simply reflect a best guess as to the type of data each will contain. 

@property (assign, nonatomic) NSInteger _id;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSNumber *zipcode;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *pavementType;
@property (strong, nonatomic) NSString *imagePath;

@property (strong, nonatomic) NSNumber *averageRating;
@property (strong, nonatomic) NSNumber *averagePrice;
@property (strong, nonatomic) NSNumber *distance;


@end