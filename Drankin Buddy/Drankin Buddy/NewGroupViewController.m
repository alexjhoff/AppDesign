//
//  NewGroupViewController.m
//  Drankin Buddy
//
//  Created by Alex Hoff on 12/2/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import "NewGroupViewController.h"

@interface NewGroupViewController ()

@end

@implementation NewGroupViewController

@synthesize groupName;
BOOL moveON;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [groupName resignFirstResponder];
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

- (IBAction)createNewGroup:(id)sender {
    NSString *name = self.groupName.text;
    PFQuery *getGrops = [PFQuery queryWithClassName:@"Groups"];     //query the class
    NSArray *allCategories = [getGrops findObjects];
    BOOL pass = NO;
    for (PFObject *temp in allCategories) {
        NSString *groupName = [temp objectForKey:@"Name"];
        if ([groupName isEqualToString:name]) {
            pass = YES;
            break;
        }
        
    }
    if (pass) {                        //if the group name is already there
        moveON = NO;
        UIAlertView *denied;
        denied = [[UIAlertView alloc]
                  initWithTitle:@"Group Name Already Taken"
                  message:@"Please try again"
                  delegate:self
                  cancelButtonTitle:@"OK"
                  otherButtonTitles: nil];
        [denied show];
    }
    else{
        PFObject *newGroup = [PFObject objectWithClassName:@"Groups"];
        newGroup[@"Name"] = name;
        [newGroup save];
        [[PFUser currentUser] setObject:[newGroup objectId] forKey:@"groups"]; //assign the groups name objectID to the users groups array
        [[PFUser currentUser] saveInBackground];                       //save all changes, overwrites previous group
        moveON = YES;
    }

}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"s1"])
    {
        if (moveON)
            return YES;
        else
            return NO;
    }
    else
        return YES;
    
}
@end
