//
//  CalculatorBrain.h
//  Calculator
//
//  Created by 다람군 on 12. 5. 2..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    EC_NOERROR = 0,
    EC_ZERODIVIDE = 1,
    EC_FAILURESQRT = 2,
} ErrorCode;

@interface CalculatorBrain : NSObject
{
    double operand, waitingOperand;
    double memory;
    NSString * waitingOperation;
    ErrorCode errorRaised;
    
    NSMutableArray * internalExpression;
    NSDictionary * varValues;
}

- (void) setOperand:(double)anOperand;
- (void) setVariableAsOperand:(NSString*)variableName;
- (double) performOperation:(NSString *)operation;
- (double) performMemory:(NSString *)func;
- (double) performClear;

@property (readonly) id expression;
@property (readonly) ErrorCode errorRaised;
@property (readonly) NSMutableArray* internalExpression;
@property (readonly) NSDictionary* varValues;

+ (double) evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary*)variables;
+ (NSSet*) variablesInExpression:(id)anExpression;
+ (NSString*)descriptionOfExpression:(id)anExpression;

+ (id)propertyListForExpression:(id)anExpression;
+ (id)expressionForPropertyList:(id)propertyList;

@end
