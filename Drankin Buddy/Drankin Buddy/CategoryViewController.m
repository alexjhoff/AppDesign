//
//  CategoryViewController.m
//  Drankin Buddy
//
//  Created by Alex Hoff on 11/10/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import "CategoryViewController.h"


@interface CategoryViewController ()

@end

@implementation CategoryViewController

@synthesize mapview, characterName, usrIndex;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)getLocation:(id)sender{
    mapview.delegate = self;
    mapview.showsUserLocation = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    characterName.text = [usrIndex objectForKey:@"username"];
    
    mapview.mapType = MKMapTypeStandard;
    //mapview.showsUserLocation = YES;
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0, 0.0}};
    region.center.latitude = [[usrIndex objectForKey:@"Latitude"]doubleValue];
    region.center.longitude = [[usrIndex objectForKey:@"Longitude"]doubleValue];
    region.span.longitudeDelta = 0.1;
    region.span.latitudeDelta = 0.1;
    [mapview setRegion:region animated:YES];
 
    MapPin *ann = [[MapPin alloc] init];
    ann.title = [usrIndex objectForKey:@"username"];
    ann.subtitle = [NSString stringWithFormat:@"%@%% battery",[usrIndex objectForKey:@"battery"]];
    ann.coordinate = region.center;
    [mapview addAnnotation:ann];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
