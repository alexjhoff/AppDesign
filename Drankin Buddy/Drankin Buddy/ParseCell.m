//
//  ParseCell.m
//  Drankin Buddy
//
//  Created by Alex Hoff on 12/6/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import "ParseCell.h"

@implementation ParseCell

@synthesize usrTitle, usrLocation, battery;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
