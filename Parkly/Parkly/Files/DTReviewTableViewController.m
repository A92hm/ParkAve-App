//
//  DTReviewTableViewController.m
//  Parkly
//
//  Created by Shelby Vanhooser on 2/25/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTReviewTableViewController.h"
#import "DTReviewTableCell.h"

@interface DTReviewTableViewController ()

@property (strong, nonatomic) NSArray *reviews;

@end

@implementation DTReviewTableViewController

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
  DTReview *newReview = [[DTReview alloc] init];
  newReview.title = @"Meh";
  newReview.body = @" Lorem ipsum dolor sit amet foo bar  Lorem ipsum dolor sit amet foo bar  Lorem ipsum dolor sit amet foo bar  Lorem ipsum dolor sit amet foo bar  Lorem ipsum dolor sit amet foo bar  Lorem ipsum dolor sit amet foo bar ";
  newReview.stars = @"2 / 5";
  newReview.date = @"11/5/13";
  newReview.reviewer_id = @"Bob";
  
  DTReview *anotherReview = [[DTReview alloc] init];
  anotherReview.title = @"Why is this lot so bad???";
  anotherReview.body = @"Meow";
  anotherReview.stars = @"4 / 5";
  anotherReview.date = @"11/5/13";
  anotherReview.reviewer_id = @"Moe";
  self.reviews = @[newReview, anotherReview];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View implementation methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.reviews count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"cell";
  DTReviewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
  [cell initWithReview:self.reviews[indexPath.row]];
  return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  DTReview *review = self.reviews[indexPath.row];
  return MAX(120.0, [self heightForText:review.body]);
  //return 60.0 + [self heightForText:review.body];
}

-(CGFloat)heightForText:(NSString *)text
{
  UITextView *textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, 228, 600)];
  textView.text = text;
  textView.font = [UIFont fontWithName:@"AvenirNext-MediumItalic" size:14.0f];
  [textView sizeToFit];
  return textView.frame.size.height;
}

@end
