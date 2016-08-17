//
//  SecondViewController.m
//  Drankin Buddy
//
//  Created by Alex Hoff on 11/5/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isYelpInstalled {
    return [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"yelp:"]];
}

- (IBAction)goToYelp:(id)sender {
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"yelp:///search?term=resturants"]];
}



@end
