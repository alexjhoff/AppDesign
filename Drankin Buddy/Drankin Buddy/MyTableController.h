//
//  MyTableController.h
//  Drankin Buddy
//
//  Created by Alex Hoff on 11/17/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CategoryViewController.h"
#import "ParseCell.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface MyTableController : UIViewController <UITableViewDelegate, CLLocationManagerDelegate> {
    NSMutableArray *usersArray;
    NSTimer *timer;
}

@property (strong, nonatomic) CLLocationManager *location;

@property (weak, nonatomic) IBOutlet UITableView *usersTable;

@end
