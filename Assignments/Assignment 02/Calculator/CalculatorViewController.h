//
//  CalculatorViewController.h
//  Calculator
//
//  Created by 다람군 on 12. 5. 2..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController
{
    IBOutlet UILabel * display;
    
    CalculatorBrain * brain;
    
    BOOL userIsInTheMiddleOfTypingANumber;
}

- (IBAction) digitPressed:(UIButton*)sender;
- (IBAction) operationPressed:(UIButton*)sender;
- (IBAction) memoryPressed:(UIButton*)sender;
- (IBAction) clearPressed:(UIButton*)sender;

- (IBAction) setVariableAsOperand:(UIButton*)sender;
- (IBAction) solvePressed:(UIButton*)sender;

@end
