//
//  ViewController.m
//  Collector
//
//  Created by 다람군 on 12. 3. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) updateUI
{
    totalNumbers.text = [NSString stringWithFormat:@"%d", model.totalNumberCount];
    totalStrings.text = [NSString stringWithFormat:@"%d", model.totalStringCount];
}

- (IBAction)collect:(UIButton*)sender
{
    if(!model) model = [[Collector alloc] init];
    
    double doubleValue = 0;// = [sender.titleLabel.text doubleValue];
    NSScanner * scanner = [[NSScanner alloc] initWithString:sender.titleLabel.text];
    if([scanner scanDouble:&doubleValue])
    //if(doubleValue)
    {
        [model collect:[NSNumber numberWithDouble:doubleValue]];
    }
    else
    {
        [model collect:sender.titleLabel.text];
    }
    
    [self updateUI];
}

- (void) dealloc
{
    [model dealloc];
    [super dealloc];
}

@end
