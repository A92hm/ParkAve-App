//
//  DTUser.h
//  Parkly
//
//  Created by Shelby Vanhooser on 2/21/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTUser : NSObject

//These properties correspond to the email sent out declaring the data stored in the webserver.  The types simply reflect a best guess as to the type of data each will contain.
@property (strong, nonatomic) NSString* __v;
@property (strong, nonatomic) NSString* _id;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *birthdate;
@property (strong, nonatomic) NSString *phone;

@end