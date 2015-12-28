//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by 다람군 on 12. 3. 26..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "PsychologistViewController.h"

@interface PsychologistViewController()

- (void) showDiagnosis:(int) diagnosis;

@end

@implementation PsychologistViewController

- (ViewController*) viewController
{
    if(_viewController == nil) _viewController = [[ViewController alloc] init/*WithNibName:@"ViewController" bundle:nil*/];
    [_viewController retain];
    return _viewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"심리 상담가";
    }
    return self;
}


- (void) showDiagnosis:(int) diagnosis
{
    self.viewController.happiness = diagnosis;
    self.viewController.title = [NSString stringWithFormat:@"%d", diagnosis];
    if(self.navigationController.view.window == nil)
    {
        [self.navigationController pushViewController:self.viewController animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (IBAction)sadPressed
{
    [self showDiagnosis:0];
}

- (IBAction)sosoPressed
{
    [self showDiagnosis:50];
}

- (IBAction)happyPressed
{
    [self showDiagnosis:100];
}

- (void) dealloc
{
    [self.viewController release];
    [super dealloc];
}

@end
