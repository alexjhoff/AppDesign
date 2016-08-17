//
//  LoginViewController.m
//  Drankin Buddy
//
//  Created by Alex Hoff on 11/10/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import "LoginViewController.h"


BOOL moveON;
@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize groupName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ParseViewController *login = [[ParseViewController alloc] init];
    login.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton | PFLogInFieldsPasswordForgotten;
    login.delegate = self;
    ParseNewUserViewController *signUpViewController = [[ParseNewUserViewController alloc] init];
    signUpViewController.delegate = self;
    login.signUpController = signUpViewController;
    //[self presentViewController:login animated:YES completion:nil];
    
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

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewControllerDidCancelLogIn: (PFSignUpViewController *)signUpController{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)joinGroup:(id)sender {
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
    if (pass) {                                                 //if the group name is found
        [[PFUser currentUser] setObject:name forKey:@"groups"]; //assign the groups name objectID to the users groups array
        [[PFUser currentUser] saveInBackground];
        moveON = YES;
    }
    else{
        moveON = NO;
        UIAlertView *denied;
        denied = [[UIAlertView alloc]
                  initWithTitle:@"Invalid Group Name"
                  message:@"Please try again or create a new group"
                  delegate:self
                  cancelButtonTitle:@"OK"
                  otherButtonTitles: nil];
        [denied show];
        return;
    }
}

- (IBAction)createGroup:(id)sender {
    [self performSegueWithIdentifier:@"new" sender:self];
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
        return NO;
    
}

@end
