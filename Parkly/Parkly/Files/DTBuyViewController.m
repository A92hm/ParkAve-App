//
//  DTBuyViewController.m
//  Parkly
//
//  Created by Shelby Vanhooser on 3/8/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTBuyViewController.h"
#import "DTReceiptViewController.h"
#import "DTModel.h"

@interface DTBuyViewController ()

@property (strong, nonatomic) DTLoginViewController *loginViewController;
@property (strong, nonatomic) DTSignupViewController *signupViewController;

@end

@implementation DTBuyViewController

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
  [self populateFields];
  [self checkUserStatus];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)populateFields
{
  self.lotNameLabel.text = self.theLot.title;
  
  [[DTModel sharedInstance] getUsernameForUserID:self.theLot.user_id success:^(NSURLSessionDataTask *task, NSString *name) {
    self.lotOwnerLabel.text = name;
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    self.lotOwnerLabel.text = @"Park Ave";
  }];
  
  self.lotDistanceLabel.text = [NSString stringWithFormat:@"%.1f", self.theLot.distance.floatValue];
  self.lotRatingLabel.text = [NSString stringWithFormat:@"%d / 5", self.theLot.averageRating.intValue];
  self.spotTypeLabel.text = self.theSpot.surface;
  self.spotDateLabel.text = self.theSpot.startDate;
  self.spotPriceLabel.text = [NSString stringWithFormat:@"%.2f", self.theSpot.price.floatValue];
}

- (IBAction)tryToReserve:(id)sender
{
  if([[DTModel sharedInstance] userHasAccount] && [[DTModel sharedInstance] userIsLoggedIn]){
    [[DTModel sharedInstance] purchaseSpot:self.theSpot forUser:[[DTModel sharedInstance] currentUser] withCar:[[DTModel sharedInstance] defaultCar] success:^(NSURLSessionDataTask *task, id responseObject) {
      [self performSegueWithIdentifier:@"goToReceipt" sender:self];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      NSLog(@"Unable to purchase spot : %@", error);
      [[[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Unable to purchase spot.  Error : %d", [error code]] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    }];
  } else if([[DTModel sharedInstance] userHasAccount] && ![[DTModel sharedInstance] userIsLoggedIn]){
      [self performSegueWithIdentifier:@"pushToLogin" sender:self];
  } else {
    [self performSegueWithIdentifier:@"pushToSignup" sender:self];
  }
}

-(NSString*)generateReceipt
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateStyle:NSDateFormatterMediumStyle];
  NSString *currentDate = [formatter stringFromDate:[NSDate date]];
  return [NSString stringWithFormat:@"Purchaser : %@\nSeller : %@\nDate of Purchase : %@\nAmount of Purchase : %@\nDate of Reservation : %@\nLot Name : %@\nLot Location : %@\nSpot Surface Type : %@", [DTModel sharedInstance].currentUser._id, self.theLot.user_id, currentDate, [NSString stringWithFormat:@"%.2f", self.theSpot.price.floatValue], self.theSpot.startDate, self.theLot.title, [NSString stringWithFormat:@"%.4f, %.4f", self.theLot.lat.floatValue, self.theLot.lon.floatValue], self.theSpot.surface];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([[segue identifier] isEqualToString:@"goToReceipt"]){
    DTReceiptViewController *dest = [segue destinationViewController];
    dest.theReceipt = [self generateReceipt];
    dest.theItem = [self mapItem];
    dest.span = MKCoordinateSpanMake(self.theLot.distance.floatValue, self.theLot.distance.floatValue);
    dest.coordinate = CLLocationCoordinate2DMake(self.theLot.lat.floatValue, self.theLot.lon.floatValue);
  } else if([[segue identifier] isEqualToString:@"pushToLogin"]) {
    self.loginViewController = [segue destinationViewController];
    self.loginViewController.delegate = self;
  } else if([[segue identifier] isEqualToString:@"pushToSignup"]){
    self.signupViewController = [segue destinationViewController];
    self.signupViewController.delegate = self;
  }
}

-(MKMapItem*)mapItem
{
  CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.theLot.lat.floatValue, self.theLot.lon.floatValue);
  MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
  MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
  item.name = self.theLot.title;
  //[item openInMapsWithLaunchOptions:nil];
  return item;
}

-(void)checkUserStatus
{
  if([[DTModel sharedInstance] userHasAccount] && [[DTModel sharedInstance] userIsLoggedIn]){
    [self.reserveButton setEnabled:YES];
    [self.reserveButton setAlpha:1.0];
  } else {
    [self.reserveButton setEnabled:NO];
    [self.reserveButton setAlpha:0.5];
  }
}

- (IBAction)logIn:(id)sender
{
  [self performSegueWithIdentifier:@"pushToLogin" sender:self];
}

- (IBAction)signup:(id)sender
{
  [self performSegueWithIdentifier:@"pushToSignup" sender:self];
}

-(void)dismissLoginViewController
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissSignupViewController
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
