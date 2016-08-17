//
//  CategoryViewController.h
//  Drankin Buddy
//
//  Created by Alex Hoff on 11/10/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "MapPin.h"


@interface CategoryViewController : UIViewController <UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate>{
    MKMapView *mapview;
}

-(IBAction)getLocation:(id)sender;

@property (strong) PFObject *usrIndex;

@property (nonatomic, retain) IBOutlet MKMapView *mapview;

@property (strong, nonatomic) IBOutlet UILabel *characterName;


@end
