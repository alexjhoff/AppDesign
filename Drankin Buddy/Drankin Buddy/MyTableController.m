//
//  MyTableController.m
//  Drankin Buddy
//
//  Created by Alex Hoff on 11/17/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import "MyTableController.h"

@interface MyTableController()

@end

@implementation MyTableController

@synthesize location, usersTable;

int userTime = 0; //only notifies user if event just happened or happened 10min, 1hr, or 2hrs ago

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    usersArray = [[NSMutableArray alloc]init];
    //can be turned off because eats up a lot of battery
    self.location=[[CLLocationManager alloc] init];
    location.delegate = self;
    if(IS_OS_8_OR_LATER) {
        [location requestWhenInUseAuthorization];
        [location requestAlwaysAuthorization];
    }
    self.location.desiredAccuracy = kCLLocationAccuracyBest;
    self.location.distanceFilter = kCLDistanceFilterNone;
    [self.location startUpdatingLocation];
    
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    int bat = [[UIDevice currentDevice] batteryLevel];
    bat *= 100;
    [[PFUser currentUser] setObject:[NSNumber numberWithInt:bat] forKey:@"battery"];
    [[PFUser currentUser] save];
    
    [super viewDidLoad];
    self.tabBarController.navigationItem.hidesBackButton = NO;
    [self performSelector:@selector(retrieveFromParse)];
    [self startTimer];
}

-(IBAction)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                  target:self
                                                selector:@selector(someAction:)
                                                userInfo:nil
                                                 repeats:YES];
}

//The method the timer will call when fired
-(void)someAction:(NSTimer *)aTimer {
    userTime++;
    [self performSelector:@selector(retrieveFromParse)];
}


-(IBAction)stopTimer {
    [timer invalidate];
}

- (void) retrieveFromParse {
    if(usersArray!=nil){
        usersArray=nil;
        usersArray=[NSMutableArray new];
    }
    PFQuery *query = [PFUser query];
    NSArray *temp = [query findObjects];
    NSString *userGroup = [[PFUser currentUser] objectForKey:@"groups"];
    NSString *userName = [[PFUser currentUser] objectForKey:@"username"];
    for (PFObject *tempObject in temp) {
        NSString *groupName = [tempObject objectForKey:@"groups"];
        NSString *tempName = [tempObject objectForKey:@"username"];
        if ([groupName isEqualToString:userGroup]) {
            if ([userName isEqual:tempName]) {
                [usersArray insertObject:tempObject atIndex:0];
            }
            else
                [usersArray addObject:tempObject];
        }
    }
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    int bat = [[UIDevice currentDevice] batteryLevel];
    bat *= 100;
    [[PFUser currentUser] setObject:[NSNumber numberWithInt:bat] forKey:@"battery"];
    [[PFUser currentUser] save];
    [usersTable reloadData];
}

//*********************Setup table of folder names ************************

//get number of sections in tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

//get number of rows by counting number of folders
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return usersArray.count;
}

//setup cells in tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //setup cell
    static NSString *CellIdentifier = @"usersCell";
    ParseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFObject *tempObject = [usersArray objectAtIndex:indexPath.row];

    NSString *userName = [tempObject objectForKey:@"username"];
    cell.usrTitle.text = userName;
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:[[tempObject objectForKey:@"Latitude"]doubleValue] longitude:[[tempObject objectForKey:@"Longitude"]doubleValue]];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:[[[PFUser currentUser] objectForKey:@"Latitude"]doubleValue] longitude:[[[PFUser currentUser] objectForKey:@"Longitude"]doubleValue]];
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    int usrLoc = distance;
    if (usrLoc >= 50 && (userTime == 1 | userTime == 10 | userTime == 60 | userTime == 120)) { //the person is over 50 m away from the user
        UILocalNotification *locationNotify = [[UILocalNotification alloc] init];
        locationNotify.alertBody = [NSString stringWithFormat:@"%@ has left your area! Make sure %@ is doing ok",userName, userName];
        locationNotify.fireDate = [NSDate date];
        locationNotify.timeZone = [NSTimeZone defaultTimeZone];
        locationNotify.repeatInterval = 0;
        [[UIApplication sharedApplication] presentLocalNotificationNow:locationNotify];
    }
    cell.usrLocation.text = [NSString stringWithFormat:@"%d m",usrLoc];
    
    int bat = [[tempObject objectForKey:@"battery"]integerValue];
    if (bat >= 70) {
        [cell.battery setImage:[UIImage imageNamed:@"full.png"]];
     }
    else if (bat >= 30){
        [cell.battery setImage:[UIImage imageNamed:@"half.png"]];
    }
    else if (bat >= 10){
        [cell.battery setImage:[UIImage imageNamed:@"20.png"]];
    }
    else {
        [cell.battery setImage:[UIImage imageNamed:@"dead.png"]];
        if (userTime == 1 | userTime == 10 | userTime == 60 | userTime == 120) {
            UILocalNotification *batteryNotify = [[UILocalNotification alloc] init];
            batteryNotify.alertBody = [NSString stringWithFormat:@"%@'s battery is almost dead! Get in touch with %@ before their phone dies!",userName, userName];
            batteryNotify.fireDate = [NSDate date];
            batteryNotify.timeZone = [NSTimeZone defaultTimeZone];
            batteryNotify.repeatInterval = 0;
            [[UIApplication sharedApplication] presentLocalNotificationNow:batteryNotify];
        }
    }
    
    return cell;
}


//user selects folder to add tag to
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = self.storyboard;
    CategoryViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"description"];
    dvc.usrIndex = [usersArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    
    double longNew = newLocation.coordinate.longitude;
    double latNew = newLocation.coordinate.latitude;
    
    [[PFUser currentUser] setObject:[NSNumber numberWithDouble:longNew] forKey:@"Longitude"];
    [[PFUser currentUser] setObject:[NSNumber numberWithDouble:latNew] forKey:@"Latitude"];
    [[PFUser currentUser] save];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *msg = @"Error obtaining location";
    
    UIAlertView *alert;
    alert = [[UIAlertView alloc]
             initWithTitle:@"Error"
             message:msg
             delegate:self
             cancelButtonTitle:@"Ok"
             otherButtonTitles: nil];
    [alert show];
}

@end
