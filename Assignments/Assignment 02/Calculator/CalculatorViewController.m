//
//  CalculatorViewController.m
//  Calculator
//
//  Created by 다람군 on 12. 5. 2..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()

@property (retain, nonatomic) UILabel* display;

@end

@implementation CalculatorViewController

@synthesize display;

- (CalculatorBrain*) brain
{
    if(!brain) brain = [[CalculatorBrain alloc] init];
    return brain;
}

- (IBAction) digitPressed:(UIButton*)sender
{
    NSString * digit = [[sender titleLabel] text];
    if([digit isEqual:@"."])
    {
        // 디스플레이에 점이 있는지 검사합니다
        NSRange range = [[display text] rangeOfString:@"."];
        if(range.location == NSNotFound)
        {
            // 없다면 맨 뒤에 점을 붙입니다.
            [display setText:[[display text] stringByAppendingString:@"."]];
            userIsInTheMiddleOfTypingANumber = YES;
        }
    }
    else
    {
        if(userIsInTheMiddleOfTypingANumber)
            display.text = [[display text]  stringByAppendingString:digit];
        else
        {
            display.text = digit;
            userIsInTheMiddleOfTypingANumber = YES;
        }
    }
}

- (IBAction) operationPressed:(UIButton*)sender
{
    if(userIsInTheMiddleOfTypingANumber)
    {
        [self brain].operand = [[display text] doubleValue];
        //[[self brain] setOperand:[[display text] doubleValue]];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    
    NSString * operation = [sender titleLabel].text;
    double result = [[self brain] performOperation:operation];
    if(![CalculatorBrain variablesInExpression:[brain internalExpression]])
        display.text = [NSString stringWithFormat:@"%g", result];
    else
        display.text = [CalculatorBrain descriptionOfExpression:brain.internalExpression];
    
    if([self brain].errorRaised != EC_NOERROR)
    {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error raised" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
        [av autorelease];
    }
}

- (IBAction) memoryPressed:(UIButton*)sender
{
    if(userIsInTheMiddleOfTypingANumber)
    {
        [[self brain] setOperand:[[display text] doubleValue]];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    double result = [[self brain] performMemory:[[sender titleLabel] text]];
    display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction) clearPressed:(UIButton*)sender
{
    double result = [brain performClear];
    display.text = [NSString stringWithFormat:@"%g", result];
    userIsInTheMiddleOfTypingANumber = NO;
}

- (IBAction) setVariableAsOperand:(UIButton*)sender
{
	NSString *digit = sender.titleLabel.text; 
 	[brain setVariableAsOperand:digit];
}

- (IBAction) solvePressed:(UIButton*)sender
{
	double result = [CalculatorBrain evaluateExpression:brain.internalExpression
									usingVariableValues:brain.varValues];
	display.text = [NSString stringWithFormat:@"%g", result];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[self brain] release];
    brain = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
