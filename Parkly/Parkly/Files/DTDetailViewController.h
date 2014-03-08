//
//  DTDetailViewController.h
//  Parkly
//
//  Created by Shelby Vanhooser on 2/21/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTParkingLot.h"
#import "DTSpotTableViewController.h"

@interface DTDetailViewController : UIViewController <DTSpotTableViewControllerDelegate>
- (IBAction)bookSpot:(id)sender;

@property (strong, nonatomic) DTParkingLot *lot;

@property (strong, nonatomic) IBOutlet UILabel *lotOwner;
@property (strong, nonatomic) IBOutlet UILabel *distanceToVenue;
@property (strong, nonatomic) IBOutlet UILabel *averageReview;
@property (strong, nonatomic) IBOutlet UILabel *averagePrice;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *bookItButton;

@end