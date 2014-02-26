//
//  DTLoginViewController.m
//  Parkly
//
//  Created by Shelby Vanhooser on 2/19/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTLoginViewController.h"
#import "DTModel.h"
#import "DTUser.h"

@interface DTLoginViewController ()

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
    [[DTModel sharedInstance] getAllUsers:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray* array = responseObject;
        for (DTUser* user in array) {
            NSLog(@"%@", user);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
  [self performSegueWithIdentifier:@"goToMain" sender:self];
}

- (IBAction)signupButtonPressed:(id)sender {
  
}


@end
