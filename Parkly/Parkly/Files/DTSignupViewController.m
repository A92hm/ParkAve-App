//
//  DTSignupViewController.m
//  Parkly
//
//  Created by Shelby Vanhooser on 3/9/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTSignupViewController.h"
#import "DTLoginViewController.h"
#import "DTUser.h"
#import "DTModel.h"

@interface DTSignupViewController ()

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;

@property (strong, nonatomic) IBOutlet UIScrollView *theScrollView;

@end

@implementation DTSignupViewController

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
  [self.theScrollView setContentSize:CGSizeMake(320, 800)];
  //NSLog(@"Frame : %.f, %.f, %.f, %.f\nContent : %.f, %.f", self.theScrollView.frame.origin.x, self.theScrollView.frame.origin.y, self.theScrollView.frame.size.width, self.theScrollView.frame.size.height, self.theScrollView.contentSize.width, self.theScrollView.contentSize.height);
  [self.theScrollView setScrollEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(DTUser*)userFromFields
{
  DTUser *theUser = [[DTUser alloc] init];
  theUser.firstName = self.firstNameField.text;
  theUser.lastName = self.lastNameField.text;
  theUser.email = self.emailField.text;
  theUser.password = self.passwordField.text;
  theUser.birthdate = self.dateOfBirthField.text;
  theUser.phone = self.phoneField.text;
  theUser.averageRating = [[NSNumber alloc] initWithInt:0];
  
  return theUser;
}

- (IBAction)signup:(id)sender
{
  [[DTModel sharedInstance] createUser:[self userFromFields] success:^(NSURLSessionDataTask *task, DTUser *newUser) {
    [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Successfully created an account.  Welcome to Park Ave." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show
     ];
    [self.delegate dismissSignupViewController];
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"%@", error);
    [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error creating an account.  Perhaps there's a problem with the network connection?" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
  }];
}

- (IBAction)cancel:(id)sender
{
  [self.delegate dismissSignupViewController];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
  [self.theScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y - 30.0f) animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([[segue identifier] isEqualToString:@"pushToLogIn"]){
    [[segue destinationViewController] setDelegate:self.delegate];
  }
}

- (IBAction)tap:(id)sender
{
  [self.firstNameField resignFirstResponder];
  [self.lastNameField resignFirstResponder];
  [self.emailField resignFirstResponder];
  [self.passwordField resignFirstResponder];
  [self.dateOfBirthField resignFirstResponder];
  [self.phoneField resignFirstResponder];
  [self.theScrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
}
- (IBAction)goToLogIn:(id)sender
{
  [self performSegueWithIdentifier:@"pushToLogIn" sender:self];
}

@end
