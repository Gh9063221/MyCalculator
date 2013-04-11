//
//  ZHTDoCalculate.m
//  MyCalculator
//
//  Created by zht on 13-4-9.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#import "ZHTDoCalculate.h"

@implementation ZHTDoCalculate

- (NSString *) notRounding:(NSDecimalNumber *)forRounding
                afterPoint:(int)position {
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *roundedOunces;
    roundedOunces = [forRounding decimalNumberByRoundingAccordingToBehavior:roundingBehavior]; 
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

- (void) runOperation:(NSString *) currentNumber {
    NSDecimalNumber *left = [NSDecimalNumber decimalNumberWithString:_leftOperand];
    NSDecimalNumber *right = [NSDecimalNumber decimalNumberWithString:_rightOperand];
    
    if ([_operation isEqualToString:@"+"]) {
        _result = [left decimalNumberByAdding:right];
    }
    else if ([_operation isEqualToString:@"-"]) {
        _result = [left decimalNumberBySubtracting:right];
    }
    else if ([_operation isEqualToString:@"*"]) {
        _result = [left decimalNumberByMultiplyingBy:right];
    }
    else if ([_operation isEqualToString:@"/"]) {
        if ([right doubleValue] == 0.0) {
            _result = [NSDecimalNumber decimalNumberWithString:@"00000000000000"];
        }
        else {
            _result = [left decimalNumberByDividingBy:right];
        }
    }
    _result = [NSDecimalNumber decimalNumberWithString:[self notRounding:_result afterPoint:4]];
}

@end
