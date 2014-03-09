//
//  DTTableCell.m
//  Parkly
//
//  Created by Shelby Vanhooser on 2/21/14.
//  Copyright (c) 2014 DevTeam14. All rights reserved.
//

#import "DTLotTableCell.h"

@implementation DTLotTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithLot:(DTParkingLot*)lot
{
  self.ratingLabel.text = [NSString stringWithFormat:@"%@", lot.averageRating];
  self.distanceLabel.text = [NSString stringWithFormat:@"%.2f", lot.distance.floatValue];
  self.titleLabel.text = lot.user_id;
  self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", lot.averagePrice.floatValue];
}

-(float)averagePriceForLot:(DTParkingLot*)lot
{
  return 20.0f;
}

@end
