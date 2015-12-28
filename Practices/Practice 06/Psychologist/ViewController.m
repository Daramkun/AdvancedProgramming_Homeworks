//
//  ViewController.m
//  Happiness
//
//  Created by 다람군 on 12. 3. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction) happinessChanged:(UISlider *)sender;

@end

@implementation ViewController

@synthesize faceView = _faceView, slider = _slider;
@synthesize happiness = _happiness;

- (void) updateUI
{
    self.slider.value = self.happiness;
    [self.faceView setNeedsDisplay];
}

- (void) setHappiness:(int)h
{
    if(h < 0) h = 0;
    if(h > 100) h = 100;
    _happiness = h;
    self.title = [NSString stringWithFormat:@"%d", _happiness];
    [self updateUI];
}

- (IBAction) happinessChanged:(UISlider*)sender
{
    self.happiness = sender.value;
}

- (float) smileForFaceView:(FaceView *)requestor
{
    float smile = 0;
    if(requestor == self.faceView) smile = (((float)self.happiness - 50) / 50);
    return smile;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.faceView.delegate = self;
    
    /*
    UIPinchGestureRecognizer * pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)];
    [self.faceView addGestureRecognizer:pinchRecognizer];
    */
    [self updateUI];
}

- (void) releaseOutlets
{
    self.faceView = nil;
    self.slider = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [self releaseOutlets];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    //return YES;
}

@end
