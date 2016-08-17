//
//  ThirdViewController.h
//  Drankin Buddy
//
//  Created by Alex Hoff on 11/5/14.
//  Copyright (c) 2014 Alex Hoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>

@interface ThirdViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate, MFMessageComposeViewControllerDelegate>



-(IBAction)textYoEx:(id)sender;

- (IBAction)showPicker:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *firstName;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumber;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerWheel;
@property (strong, nonatomic) NSArray *PickerData;

@end
