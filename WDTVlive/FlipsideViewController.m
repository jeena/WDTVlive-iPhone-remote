//
//  FlipsideViewController.m
//  WDTVlive
//
//  Created by Jeena Paradies on 04/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize domain;
@synthesize username, password;
@synthesize switchUpDown, switchLeftRight;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    
    NSString *domainString = [d objectForKey:@"domain"];
    if (!domainString) {
        [d setObject:@"wdtvlive.local" forKey:@"domain"];
        [d synchronize];
    }
    
    NSString *usernameString = [d objectForKey:@"username"];
    if (!usernameString) {
        [d setObject:@"wdlxtv" forKey:@"username"];
        [d synchronize];
    }
    
    NSString *passwordString = [d objectForKey:@"password"];
    if (!passwordString) {
        [d setObject:@"wdlxtv" forKey:@"password"];
        [d synchronize];
    }

    self.domain.text = [d objectForKey:@"domain"];
    self.username.text = [d objectForKey:@"username"];
    self.password.text = [d objectForKey:@"password"];
    
    self.switchUpDown.on = [d boolForKey:@"switchUpDown"];
    self.switchLeftRight.on = [d boolForKey:@"switchLeftRight"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)save:(id)sender
{
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];

    if (sender == self.domain) {
        [d setObject:self.domain.text forKey:@"domain"];
    }
    else if (sender == self.username)
    {
        [d setObject:self.username.text forKey:@"username"];
    }
    else if (sender == self.password)
    {
        [d setObject:self.password.text forKey:@"password"];    
    }
    else if (sender == self.switchUpDown)
    {
        [d setBool:self.switchUpDown.on forKey:@"switchUpDown"];
    }
    else if (sender == self.switchLeftRight)
    {
        [d setBool:self.switchLeftRight.on forKey:@"switchLeftRight"];
    }
    
    [d synchronize];
    
    NSLog(@"f");
}

@end
