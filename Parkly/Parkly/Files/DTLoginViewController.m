//
//  DTLoginViewController.m
//  Parkly
//
//  Created by Shelby Vanhooser on 2/19/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTLoginViewController.h"
#import "AFNetworking.h"
#import "DTModel.h"

@interface DTLoginViewController ()

@property(weak, nonatomic) NSString* apiURL;

@end

@implementation DTLoginViewController

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
  
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonPressed:(id)sender {
    
    // Start Calling Authentication API
    DTModel* manager = [DTModel sharedInstance];
    
    /****************CHANGE THESE PARAMETERS********************/
    NSDictionary *parameters = @{@"email":      @"jterry94@gmail.com",
                                 @"password":   @"yolo"
                                 };
    [manager authenticateUser:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    //End Calling Authentication API
    
  [self performSegueWithIdentifier:@"goToMain" sender:self];
}

- (IBAction)signupButtonPressed:(id)sender {
  
}


@end
