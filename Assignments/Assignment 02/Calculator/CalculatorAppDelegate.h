//
//  CalculatorAppDelegate.h
//  Calculator
//
//  Created by 다람군 on 12. 5. 2..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorViewController;

@interface CalculatorAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CalculatorViewController *viewController;

@end
