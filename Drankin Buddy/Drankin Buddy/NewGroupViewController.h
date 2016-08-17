//
//  NewGroupViewController.h
//  Drankin Buddy
//
//  Created by Alex Hoff on 12/2/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@interface NewGroupViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *groupName;

- (IBAction)createNewGroup:(id)sender;

@end
