//
//  FlipsideViewController.h
//  WDTVlive
//
//  Created by Jeena Paradies on 04/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController {
    UITextField *domain;
    UITextField *username;
    UITextField *password;
    UISwitch *swithchUpDown;
    UISwitch *switchLeftRight;
}

@property (nonatomic, retain) IBOutlet UITextField *domain;
@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UISwitch *switchUpDown;
@property (nonatomic, retain) IBOutlet UISwitch *switchLeftRight;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
