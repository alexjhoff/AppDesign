//
//  ParseNewUserViewController.m
//  Drankin Buddy
//
//  Created by Alex Hoff on 12/3/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import "ParseNewUserViewController.h"

@interface ParseNewUserViewController ()

@end

@implementation ParseNewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.signUpView.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drank.png"]];
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
