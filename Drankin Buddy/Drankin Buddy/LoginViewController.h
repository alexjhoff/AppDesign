//
//  LoginViewController.h
//  Drankin Buddy
//
//  Created by Alex Hoff on 11/10/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <UIKit/UIKit.h>
#import "ParseViewController.h"
#import "ParseNewUserViewController.h"

@interface LoginViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *groupName;

- (IBAction)joinGroup:(id)sender;

- (IBAction)createGroup:(id)sender;

@end
