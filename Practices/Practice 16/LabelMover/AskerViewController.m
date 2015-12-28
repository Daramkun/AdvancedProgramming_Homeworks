//
//  AskerViewController.m
//  LabelMover
//
//  Created by 진 재연 on 12. 5. 30..
//  Copyright (c) 2012년 daramkun@daram.pe.kr. All rights reserved.
//

#import "AskerViewController.h"

@interface AskerViewController ()

@end

@implementation AskerViewController

@synthesize question;
@synthesize questionLabel, answerField;
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.answerField.delegate = self;
    self.answerField.autocapitalizationType = UITextAutocapitalizationTypeWords;
}

- (void) viewWillAppear: (BOOL)animated
{
    [super viewWillAppear:animated];
    self.questionLabel.text = self.question;
    self.answerField.text = nil;
    [self.answerField becomeFirstResponder];
}

- (BOOL) textFieldShouldReturn: (UITextField*) textField
{
    if([textField.text length])
    {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

- (void) textFieldDidEndEditing: (UITextField*)textField
{
    //NSLog(@"text is %@", textField.text);
    [self.delegate askerViewController:self
                        didAskQuestion:self.questionLabel.text
                          andGotAnswer:self.answerField.text];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
