//
//  MainViewController.m
//  WDTVlive
//
//  Created by Jeena Paradies on 04/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize activity;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer release];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer release];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer release];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    [recognizer release];

}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    BOOL switchUpDown = [d boolForKey:@"switchUpDown"];
    BOOL swithLeftRight = [d boolForKey:@"switchLeftRight"];
    
    UISwipeGestureRecognizerDirection left = swithLeftRight ? UISwipeGestureRecognizerDirectionLeft : UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizerDirection right = swithLeftRight ? UISwipeGestureRecognizerDirectionRight : UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizerDirection up = switchUpDown ? UISwipeGestureRecognizerDirectionUp : UISwipeGestureRecognizerDirectionDown;
    UISwipeGestureRecognizerDirection down = switchUpDown ? UISwipeGestureRecognizerDirectionDown : UISwipeGestureRecognizerDirectionUp;
    
    if (recognizer.direction == up)
    {
        [self sendButton:@"u"];
    }
    else if(recognizer.direction == down)
    {
        [self sendButton:@"d"];
    }
    else if(recognizer.direction == left)
    {
        [self sendButton:@"l"];
        [self sendButton:@"T_back"];
    }
    else if(recognizer.direction == right)
    {
        [self sendButton:@"r"];
    }    
}

- (IBAction)enter:(UIButton *)sender
{
    [self sendButton:@"n"];
}

- (IBAction)play:(UIButton *)sender
{
    [self sendButton:@"p"];
}

- (void)sendButton:(NSString *)button
{
    NSLog(@"doing: %@", button);
    [self.activity startAnimating];
    
    [self performSelectorInBackground:@selector(asynchronousButton:) withObject:button];
}

- (void)asynchronousButton:(NSString *)button
{
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    NSString *domain = [d objectForKey:@"domain"];
    NSString *username = [d objectForKey:@"username"];
    NSString *password = [d objectForKey:@"password"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@@%@/addons/remote/", username, password, domain]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[[@"button=" stringByAppendingString:button] dataUsingEncoding:NSASCIIStringEncoding]];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if (error)
    {
        NSLog(@"Error: %@", error);
    }
    else
    {
        NSString *responseDataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        //NSLog(@"Response: %@", responseDataString);
        [responseDataString release];
        NSLog(@"done");
    }
    [pool drain];
    
    [self.activity stopAnimating];
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
