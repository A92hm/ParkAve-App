//
//  DTTableViewController.h
//  Parkly
//
//  Created by Shelby Vanhooser on 2/21/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DTLotTableViewControllerDelegate <NSObject>

-(void)tableViewDidSelectRowAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface DTLotTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak) id <DTLotTableViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITableView *theTable;
@property (strong, nonatomic) NSArray *theLots;

-(void)sortByReview;
-(void)sortByPrice;
-(void)sortByDistance;
-(void)sortByName;

@end