//
//  ViewController.h
//  Calculator
//
//  Created by 다람군 on 12. 3. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CalculatorBrain.h"

@interface ViewController : UIViewController
{
    IBOutlet UILabel * display, * memory;
    CalculatorBrain * brain;
    BOOL userIsInTheMiddleOfTypingANumber;
}

- (IBAction) digitPressed:(UIButton*)sender;
- (IBAction) operationPressed:(UIButton*)sender;
- (IBAction) clearMemory:(UIButton*)sender;
- (IBAction) changedSwitch:(UISwitch*)sender;
- (IBAction) deleteLastNumber:(UIButton*)sender;

@end
