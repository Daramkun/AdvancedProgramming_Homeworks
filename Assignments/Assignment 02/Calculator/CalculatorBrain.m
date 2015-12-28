//
//  CalculatorBrain.m
//  Calculator
//
//  Created by 다람군 on 12. 5. 2..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
#import <math.h>

@implementation CalculatorBrain

@synthesize expression;
@synthesize errorRaised;
@synthesize internalExpression;
@synthesize varValues;

- (void) addToExpression:(id)keyLabel
{
    if(!internalExpression)
        internalExpression = [[NSMutableArray alloc] init];
    [internalExpression addObject:keyLabel];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        varValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @"2", @"~x", 
                     @"4", @"~a",
                     @"6", @"~b",
                     nil];
    }
    
    return self;
}

- (void) setOperand:(double)anOperand
{
    operand = anOperand;
    NSNumber *numberOperand = [NSNumber numberWithDouble: anOperand];
	[self addToExpression:numberOperand];
}

- (void) setVariableAsOperand:(NSString*)variableName
{
    variableName = [@"~" stringByAppendingString:variableName];
    [self addToExpression:variableName];
}

- (void) performWaitingOperation
{
    if([@"+" isEqual:waitingOperation])
        operand = waitingOperand + operand;
    else if([@"-" isEqual:waitingOperation])
        operand = waitingOperand - operand;
    else if([@"*" isEqual:waitingOperation])
        operand = waitingOperand * operand;
    else if([@"/" isEqual:waitingOperation])
        if(operand)
            operand = waitingOperand / operand;
        else
            errorRaised = EC_ZERODIVIDE;
}

- (BOOL) performSingleOperation:(NSString*)operation
{
    [self addToExpression:operation];
    if([@"sqrt" isEqual:operation])
        if(operand == 0 || operand < 0)
            errorRaised = EC_FAILURESQRT;
        else
            operand = sqrt(operand);
    else if([@"sin" isEqual:operation])
        operand = sin(operand);
    else if([@"cos" isEqual:operation])
        operand = cos(operand);
    else if([@"+/-" isEqual:operation])
        operand *= -1;
    else if([@"1/x" isEqual:operation])
        operand = 1 / operand;
    else
        return NO;
    return YES;
}

- (double) performOperation:(NSString *)operation
{
    errorRaised = EC_NOERROR;
    if(![self performSingleOperation:operation])
    {
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
    }
    return operand;
}

- (double) performMemory:(NSString *)func
{
    if([@"Store" isEqual:func])
        memory = operand;
    else if([@"mem+" isEqual:func])
        memory += operand;
    else if([@"recall" isEqual:func])
    {
        [self performClear];
        operand = memory;
    }
    return operand;
}

- (double) performClear
{
    operand = waitingOperand = 0;
    waitingOperation = nil;
    [internalExpression removeAllObjects];
    return operand;
}

+ (double) evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary*)variables
{
    double myDouble = 0.0;
    CalculatorBrain * workerBrain = [[CalculatorBrain alloc] init];
    for(id obj in anExpression)
    {
        if([obj isKindOfClass:[NSNumber class]])
            workerBrain.operand = [obj doubleValue];
        else if([obj hasPrefix:@"~"])
            workerBrain.operand = [[variables objectForKey:obj] doubleValue];
        else
            myDouble = [workerBrain performOperation:obj];
    }
    [workerBrain autorelease];
    return myDouble;
}

+ (NSSet*) variablesInExpression:(id)anExpression
{
    NSMutableSet * setOfVars = [NSMutableSet set];
    for(id obj in anExpression)
        if([obj isKindOfClass:[NSString class]] && [obj hasPrefix:@"~"])
            [setOfVars addObject:[obj substringToIndex:1]];
    if([setOfVars count] == 0) setOfVars = nil;
    return setOfVars;
}

+ (NSString*)descriptionOfExpression:(id)anExpression
{
    NSMutableString * expDisplayString = [[NSMutableString alloc] init];
    for(id obj in anExpression)
        if([obj isKindOfClass:[NSNumber class]])
            [expDisplayString appendString:[obj stringValue]];
        else if([obj hasPrefix:@"~"])
            [expDisplayString appendString:[obj substringFromIndex:1]];
        else if([obj isKindOfClass:[NSString class]])
            [expDisplayString appendString:obj];
    [expDisplayString autorelease];
    return expDisplayString;
}

+ (id)propertyListForExpression:(id)anExpression
{
    return anExpression;
}

+ (id)expressionForPropertyList:(id)propertyList
{
    return propertyList;
}

@end
