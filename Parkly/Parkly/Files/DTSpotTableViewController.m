//
//  DTSpotTableViewController.m
//  Parkly
//
//  Created by Shelby Vanhooser on 2/25/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTSpotTableViewController.h"
#import "DTSpotTableCell.h"
#import "DTParkingSpot.h"
#import "DTModel.h"

@interface DTSpotTableViewController ()


@end

@implementation DTSpotTableViewController

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
  [self fetchSpots];
  
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
  [self.theTable addSubview:refreshControl];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.spots count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  DTSpotTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  [cell initWithParkingSpot:self.spots[indexPath.row]];
  return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [((DTSpotTableCell*) [tableView cellForRowAtIndexPath:indexPath]) setEditing:YES animated:YES];
  [self.delegate didSelectRow];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [((DTSpotTableCell*) [tableView cellForRowAtIndexPath:indexPath]) setEditing:NO animated:YES];
  [self.delegate didDeselectRow];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return @"Available Spots";
}

-(void)refresh:(UIRefreshControl*)refresher
{
  [refresher endRefreshing];
  [self fetchSpots];
}

-(void)fetchSpots
{
  NSLog(@"%@", self.theLot);
  [[DTModel sharedInstance] getSpotsForLot:self.theLot success:^(NSURLSessionDataTask *task, NSArray *spots) {
    self.spots = spots;
    [self.theTable reloadData];
    NSLog(@"Loaded spots : %@", spots);
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    self.spots = nil;
    [self.theTable reloadData];
    NSLog(@"Failure to load spots. %@", error);
  }];
}

@end
