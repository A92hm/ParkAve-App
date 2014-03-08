//
//  DTBuyViewController.h
//  Parkly
//
//  Created by Shelby Vanhooser on 3/8/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTParkingSpot.h"
#import "DTParkingLot.h"

@protocol DTBuyViewControllerDelegate <NSObject>

-(void)didBuySpot;
-(void)didCancelBuySpot;

@end

@interface DTBuyViewController : UIViewController

@property (strong, nonatomic) DTParkingSpot *theSpot;
@property (strong, nonatomic) DTParkingLot *theLot;

@property (strong, nonatomic) IBOutlet UILabel *lotNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lotOwnerLabel;
@property (strong, nonatomic) IBOutlet UILabel *lotDistanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *lotRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *spotTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *spotDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *spotPriceLabel;


@end
