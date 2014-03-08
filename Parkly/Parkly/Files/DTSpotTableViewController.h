//
//  DTSpotTableViewController.h
//  Parkly
//
//  Created by Shelby Vanhooser on 2/25/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTParkingLot.h"

@protocol DTSpotTableViewControllerDelegate <NSObject>

-(void)didSelectRow;
-(void)didDeselectRow;

@end

@interface DTSpotTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) DTParkingLot *theLot;
@property (strong, nonatomic) IBOutlet UITableView *theTable;
@property (strong, nonatomic) NSArray *spots;

@property (weak, nonatomic) id<DTSpotTableViewControllerDelegate> delegate;

@end
