//
//  DTReview.h
//  Parkly
//
//  Created by CCEW on 2/27/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTReview : NSObject

@property (strong, nonatomic) NSString* _id;
@property (strong, nonatomic) NSString* __v;
@property (strong, nonatomic) NSString* reviewer_id;
@property (strong, nonatomic) NSString* reviewee_id;
@property (strong, nonatomic) NSString* lot_id;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSString* stars;
@property (strong, nonatomic) NSString* body;

@end
