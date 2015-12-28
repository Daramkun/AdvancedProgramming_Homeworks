//
//  PsychologistViewController.h
//  Psychologist
//
//  Created by 다람군 on 12. 3. 26..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface PsychologistViewController : UIViewController
{
    ViewController* _viewController;
}

@property (readonly) ViewController* viewController;

- (IBAction)sadPressed;
- (IBAction)sosoPressed;
- (IBAction)happyPressed;

@end
