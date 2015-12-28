//
//  PsychologistAppDelegate.h
//  Psychologist
//
//  Created by 다람군 on 12. 3. 26..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PsychologistViewController.h"

@interface PsychologistAppDelegate : NSObject <UIApplicationDelegate>
{
    PsychologistViewController * _psychologystViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PsychologistViewController * psychologistViewController;

@end
