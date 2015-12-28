//
//  CalculatorBrain.m
//  Calculator
//
//  Created by 다람군 on 12. 3. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

- (void) setOperand:(double)aDouble
{
    operand = aDouble;
}

- (double) memory
{
    return memory;
}

- (void) setMemory:(double) value
{
    memory = value;
}

- (void) setIsRadian:(bool) value
{
    isRadian = value;
}

- (void) performWaitingOperation
{
    if([@"+" isEqual:waitingOperation])
    {
        operand = waitingOperand + operand;
    }
    else if([@"-" isEqual:waitingOperation])
    {
        operand = waitingOperand - operand;
    }
    else if([@"*" isEqual:waitingOperation])
    {
        operand = waitingOperand * operand;
    }
    else if([@"/" isEqual:waitingOperation])
    {
        if(operand)
        {
            operand = waitingOperand / operand;
        }
        else if(operand == 0)
        {
            UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"오류" 
                                                          message:@"0으로 나눌 수 없습니다."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
            [av show];
            [av autorelease];
        }
    }
}

- (double) performOperation:(NSString *)operation
{
    if([operation isEqual:@"sqrt"])
    {
        if(operand <= 0)
        {
            UIAlertView * av = [[UIAlertView alloc] 
                                    initWithTitle:@"오류"
                                          message:@"제곱근을 사용할 때에는 0이나 음수를 사용할 수 없습니다." 
                                         delegate:nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
            [av show];
            [av autorelease];
        }
        else
            operand = sqrt(operand);
    }
    else if([@"1/x" isEqual:operation])
    {
        operand = 1 / operand;
    }
    else if([@"+/-" isEqual:operation])
    {
        operand *= -1;
    }
    else if([@"sin" isEqual:operation])
    {
        // 라디안이 아닌 경우 피연산자를 라디안으로 변경
        if(!isRadian) operand = operand * 3.141592f / 180.0f;
        operand = floor(sin(operand));
    }
    else if([@"cos" isEqual:operation])
    {
        // 라디안이 아닌 경우 피연산자를 라디안으로 변경
        if(!isRadian) operand = operand * 3.141592f / 180.0f;
        operand = floor(cos(operand));
    }
    // 초기화
    else if([@"C" isEqual:operation])
    {
        operand = 0;
        waitingOperation = 0;
        waitingOperand = 0;
        memory = 0;
    }
    // 메모리에 저장
    else if([@"Store" isEqual:operation])
    {
        memory = operand;
    }
    // 메모리로부터 불러옴
    else if([@"Recall" isEqual:operation])
    {
        operand = memory;
    }
    // 메모리에 덧셈
    else if([@"Mem +" isEqual:operation])
    {
        memory += operand;
    }
    else
    {
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
    }
    
    return operand;
}

@end
