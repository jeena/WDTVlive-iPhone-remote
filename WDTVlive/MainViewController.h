//
//  MainViewController.h
//  WDTVlive
//
//  Created by Jeena Paradies on 04/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
    UIActivityIndicatorView *activity;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
- (IBAction)showInfo:(id)sender;

- (void)sendButton:(NSString *)button;
- (void)asynchronousButton:(NSString *)button;
- (IBAction)enter:(UIButton *)sender;
- (IBAction)play:(UIButton *)sender;

@end
