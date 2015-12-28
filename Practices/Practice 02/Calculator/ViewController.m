//
//  ViewController.m
//  Calculator
//
//  Created by 다람군 on 12. 3. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (CalculatorBrain*) brain
{
    if(!brain) brain = [[CalculatorBrain alloc] init];
    return brain;
}

- (IBAction) digitPressed:(UIButton *)sender
{
    NSString * digit = [[sender titleLabel] text];
    
    if(userIsInTheMiddleOfTypingANumber)
    {
        [display setText:[[display text] stringByAppendingString:digit]];
    }
    else 
    {
        [display setText:digit];
        userIsInTheMiddleOfTypingANumber = YES;
    }
}

- (IBAction) operationPressed:(UIButton *)sender
{
    if(userIsInTheMiddleOfTypingANumber)
    {
        [[self brain] setOperand:[[display text] doubleValue]];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    NSString * operation = [[sender titleLabel] text];
    double result = [[self brain] performOperation:operation];
    [display setText:[NSString stringWithFormat:@"%g", result]];
}

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

@end
