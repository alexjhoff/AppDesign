//
//  ParseViewController.m
//  Drankin Buddy
//
//  Created by Alex Hoff on 12/1/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import "ParseViewController.h"

@interface ParseViewController ()

@end

@implementation ParseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.logInView.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drank.png"]];
    //self.logInView.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beer.jpg"]];
    // Do any additional setup after loading the view.
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
