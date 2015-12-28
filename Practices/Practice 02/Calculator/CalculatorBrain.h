//
//  CalculatorBrain.h
//  Calculator
//
//  Created by 다람군 on 12. 3. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
{
    double operand;
    NSString * waitingOperation;
    double waitingOperand;
}

- (void) setOperand:(double) aDouble;
- (double) performOperation:(NSString *)operation;

@end
