//
//  ParseCell.h
//  Drankin Buddy
//
//  Created by Alex Hoff on 12/6/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usrTitle;
@property (weak, nonatomic) IBOutlet UILabel *usrLocation;
@property (weak, nonatomic) IBOutlet UIImageView *battery;

@end
