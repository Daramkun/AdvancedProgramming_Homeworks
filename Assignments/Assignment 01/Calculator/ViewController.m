//
//  ViewController.m
//  Calculator
//
//  Created by 다람군 on 12. 3. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (CalculatorBrain*) brain
{
    // brain을 처음 사용하는 경우 객체를 생성합니다.
    if(!brain) brain = [[CalculatorBrain alloc] init];
    return brain;
}

// 숫자 입력 이벤트 메서드
- (IBAction) digitPressed:(UIButton *)sender
{
    NSString * digit = [[sender titleLabel] text];
 
    // 점(.)을 입력받은 경우
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
    // 파이를 입력받은 경우
    else if([digit isEqual:@"Pie"])
    {
        [display setText:@"3.141592"];
        userIsInTheMiddleOfTypingANumber = YES;
    }
    // 그 외의 숫자
    else 
    {
        // 이미 뭔가 입력받아져 있던 경우
        if(userIsInTheMiddleOfTypingANumber)
        {
            // 숫자를 맨 뒤에 붙입니다
            [display setText:[[display text] stringByAppendingString:digit]];
        }
        // 그렇지 않은 경우
        else 
        {
            // 숫자를 디스플레이에 적용한 후 입력받았다는 표시
            [display setText:digit];
            userIsInTheMiddleOfTypingANumber = YES;
        }
    }
}

// 연산자 입력 이벤트 메서드
- (IBAction) operationPressed:(UIButton *)sender
{
    if(userIsInTheMiddleOfTypingANumber)
    {
        [[self brain] setOperand:[[display text] doubleValue]];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    NSString * operation = [[sender titleLabel] text];
    // 두 피연산자와 입력된 연산자를 이용해 계산을 시도합니다.
    double result = [[self brain] performOperation:operation];
    // 계산된 결과를 디스플레이합니다.
    [display setText:[NSString stringWithFormat:@"%g", result]];
    // 또한 메모리에 저장되어 있는 값을 디스플레이합니다.
    [memory setText:[NSString stringWithFormat:@"%g", [self brain].memory]];
}

- (IBAction) clearMemory:(UIButton*)sender
{
    [self brain].memory = 0;
    // 메모리에 저장되어 있는 값을 디스플레이합니다.
    [memory setText:[NSString stringWithFormat:@"%g", [self brain].memory]];
}

- (IBAction) changedSwitch:(UISwitch*)sender
{
    // 라디안 모드로 변경합니다.
    [self brain].isRadian = sender.on;
}

- (IBAction) deleteLastNumber:(UIButton*)sender
{
    // 마지막으로 입력한 숫자를 삭제합니다.
    // 만약 모든 숫자를 삭제한 경우 0을 대입합니다.
    display.text = [[display text] substringToIndex:[[display text] length] - 1];
    if([[display text] length] == 0)
        display.text = @"0";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [[self brain] release];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
