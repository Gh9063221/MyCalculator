//
//  ZHTDoCalculate.h
//  MyCalculator
//
//  Created by zht on 13-4-9.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTDoCalculate : NSObject

@property (retain, nonatomic)NSString *operation;
@property (retain, nonatomic)NSString *leftOperand;
@property (retain, nonatomic)NSString *rightOperand;
@property (retain, nonatomic)NSDecimalNumber *result;
@property (assign, nonatomic)BOOL leftOperandEmpty;
@property (assign, nonatomic)BOOL rightOperandEmpty;
@property (assign, nonatomic)BOOL operationEmpty;

- (void) runOperation:(NSString *)currentNumber;

@end
