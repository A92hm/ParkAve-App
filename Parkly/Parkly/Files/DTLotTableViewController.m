//
//  DTTableViewController.m
//  Parkly
//
//  Created by Shelby Vanhooser on 2/21/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTLotTableViewController.h"
#import "DTLotTableCell.h"
#import "DTParkingLot.h"
#import "DTModel.h"

@interface DTLotTableViewController ()


@end

@implementation DTLotTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DTParkingLotsDB *db = [[DTParkingLotsDB alloc] init];
    
    self.parkingLots = [db getParkingLots];

//    [[DTModel sharedInstance] getAllLots:^(NSURLSessionDataTask *task, NSArray *allLots) {
//        self.theLots = allLots;
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.parkingLots count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"Fetching cell for row : %d", (int) indexPath.row);
  static NSString* identifier = @"cell";
  DTLotTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
  [cell initWithLot:self.parkingLots[indexPath.row]]; 
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.delegate tableViewDidSelectRowAtIndexPath:indexPath];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)sortByPrice
{
  NSLog(@"Sorted by price");
  self.parkingLots = [self.parkingLots sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    return [((DTParkingLot*) obj1).averagePrice compare:((DTParkingLot *) obj2).averagePrice];
  }];
  [self.theTable reloadData];
}

-(void)sortByDistance
{
  NSLog(@"Sorted by distance");
  self.parkingLots = [self.parkingLots sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    return [((DTParkingLot*) obj1).distance compare:((DTParkingLot *) obj2).distance];
  }];
  [self.theTable reloadData];
}

-(void)sortByReview
{
  NSLog(@"Sorted by average review");
  self.parkingLots = [self.parkingLots sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    return [((DTParkingLot*) obj1).averageRating compare:((DTParkingLot *) obj2).averageRating];
  }];
  [self.theTable reloadData];
}

@end
