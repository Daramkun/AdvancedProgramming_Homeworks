//
//  ViewController.m
//  LabelMover
//
//  Created by 진 재연 on 12. 5. 30..
//  Copyright (c) 2012년 daramkun@daram.pe.kr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize myLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UISwipeGestureRecognizer * swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(swipe)];
    [self.view addGestureRecognizer:swiper];
    [swiper release];
    
    UITapGestureRecognizer * taper = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(tap:)];
    [self.view addGestureRecognizer:taper];
    [taper release];
}

- (void) swipe
{
    AskerViewController * asker = [[AskerViewController alloc] init];
    asker.question = @"Who are you?";
    asker.delegate = self;
    [self presentModalViewController:asker animated:YES];
    [asker release];
}

- (void) moveLabel: (UILabel *) label toPoint:(CGPoint) p
{
    //label.center = p;
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction;
    [UIView animateWithDuration:2.0 
                          delay:0.0 
                        options:options
                     animations:^{ label.center = p; } 
                     completion:nil];
    [UIView animateWithDuration:1.0 
                          delay:0.0 
                        options:options 
                     animations:^{ 
                         label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
                                } 
                     completion:^(BOOL finished)
                                {
                                    [UIView animateWithDuration:1.0 delay:0 options:options animations:^{ 
                                            label.transform = CGAffineTransformIdentity;
                                        } completion:nil];
                                }];
}

- (void) tap: (UITapGestureRecognizer*) gesture
{
    [self moveLabel:self.myLabel toPoint:[gesture locationInView:self.view]];
}

- (void) askerViewController:(AskerViewController*)sender
              didAskQuestion:(NSString*)question
                andGotAnswer:(NSString*)answer
{
    self.myLabel.text = answer;
    CGPoint labelCenter = self.myLabel.center;
    [self.myLabel sizeToFit];
    self.myLabel.center = labelCenter;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.myLabel = nil;
}

- (void)dealloc
{
    [myLabel release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
