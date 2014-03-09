//
//  DTLotFinderViewController.m
//  Parkly
//
//  Created by Shelby Vanhooser on 2/19/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTLotFinderViewController.h"
#import "DTDetailViewController.h"

@interface DTLotFinderViewController ()

@property (strong, nonatomic) DTLotTableViewController *lotTable;
@property (strong, nonatomic) DTProfileViewController *profileViewController;

@end

@implementation DTLotFinderViewController

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
  [self.view layoutSubviews];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSelectSegment:(UISegmentedControl *)sender {
  if(sender.selectedSegmentIndex == 0){
    //Sort elements of table by price
    [self.lotTable sortByPrice];
  } else if(sender.selectedSegmentIndex == 1){
    //Sort elements of table by distance
    [self.lotTable sortByDistance];
  }else {
    //Sort elements of table by review rank
    [self.lotTable sortByReview];
  }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([[segue identifier] isEqualToString:@"embed"]){
    self.lotTable = [segue destinationViewController];
    self.lotTable.delegate = self;
  } else if([[segue identifier] isEqualToString:@"profile"]){
    self.profileViewController = [segue destinationViewController];
    self.profileViewController.delegate = self;
  } else if([[segue identifier] isEqualToString:@"pushToDetail"]){
    ((DTDetailViewController*) [segue destinationViewController]).lot = self.lotTable.parkingLots[self.lotTable.theTable.indexPathForSelectedRow.row];
  }
}

-(void)tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self performSegueWithIdentifier:@"pushToDetail" sender:self];
}

-(void)dismissProfileViewControllerSuccess
{
  [self dismissViewControllerAnimated:YES completion:^{
    
  }];
}

-(void)dismissProfileViewControllerCanceled
{
  [self dismissViewControllerAnimated:YES completion:^{
    
  }];
}

@end
