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

@interface DTSpotTableViewController ()

@property (strong, nonatomic) NSArray *spots;

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
  DTParkingSpot *spot = [[DTParkingSpot alloc] init];
  [spot setPrice:@4];
  [spot setDate:[NSDate date]];
  [spot setSpotType: @"Asphalt"];
  self.spots = @[spot];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [((DTSpotTableCell*) [tableView cellForRowAtIndexPath:indexPath]) setEditing:YES animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [((DTSpotTableCell*) [tableView cellForRowAtIndexPath:indexPath]) setEditing:NO animated:YES];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return @"Available Spots";
}

@end
