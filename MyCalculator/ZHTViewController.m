//
//  ZHTViewController.m
//  MyCalculator
//
//  Created by zht on 13-4-9.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#import "ZHTViewController.h"

@interface ZHTViewController ()

@end

@implementation ZHTViewController

#pragma mark -
#pragma init
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //draw everything
    [self addButton];
    [self addMailLabel];
    
    //init everything
    _currentNumber = [NSMutableString stringWithString:@"0"];
    _dotExist = NO;
    _justDone = NO;
    _displayCount = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark digiPressed

- (void) pushDigit:(int) num {
    [_currentNumber appendFormat:@"%d", num];
    _mainLabel.text = [_mainLabel.text stringByAppendingFormat:@"%d", num];
}

- (void) pushDot {
    [_currentNumber appendFormat:@"."];
    _mainLabel.text = [_mainLabel.text stringByAppendingFormat:@"."];
}

- (void) zeroPressed {
    //当前有小数点||当前数非0，末尾加0
    if (![_currentNumber isEqualToString:@"0"] || _dotExist == YES) {
        [self pushDigit:0];
    }
}

- (void) oneToNinePressed:(int) num {
    //只有0，先删除0
    if ([_currentNumber isEqualToString:@"0"]) {
        _mainLabel.text = [NSString stringWithFormat:@""];
        [self setCurrentNumber:(NSMutableString *)@""];
    }
    [self pushDigit:num];
}

- (void)dotpressed {
    //当前没有小数点
    if (_dotExist == NO) {
        _dotExist = YES;
        [self pushDot];
    }
}

- (void) clearPressed {
    [self setCurrentNumber:(NSMutableString *)@"0"];
    _mainLabel.text = [NSString stringWithFormat:@"0"];
    self.dotExist = NO;    
    [_doCalculate setOperation:@""];
    [_doCalculate setLeftOperand:[NSString stringWithFormat:@""]];
    [_doCalculate setRightOperand:[NSString stringWithFormat:@""]];
    [_doCalculate setLeftOperandEmpty:YES];
    [_doCalculate setRightOperandEmpty:YES];
    [_doCalculate setOperationEmpty:YES];
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    if ([self justDone]) {
        [self setCurrentNumber:(NSMutableString *)@"0"];
        [self setJustDone:NO];
        _mainLabel.text = [NSString stringWithFormat:@"0"];
    }
    NSString *digit = sender.currentTitle;
    
    if ([digit isEqualToString:@"0"])
        [self zeroPressed];
    else if ([digit isEqualToString:@"1"] ||
             [digit isEqualToString:@"2"] ||
             [digit isEqualToString:@"3"] ||
             [digit isEqualToString:@"4"] ||
             [digit isEqualToString:@"5"] ||
             [digit isEqualToString:@"6"] ||
             [digit isEqualToString:@"7"] ||
             [digit isEqualToString:@"8"] ||
             [digit isEqualToString:@"9"]) {
        [self oneToNinePressed:[digit intValue]];
    }
    else if ([digit isEqualToString:@"."])
        [self dotpressed];
    else if ([digit isEqualToString:@"C"])
        [self clearPressed];
}

#pragma mark -
#pragma mark operationPressed
- (void) inverPressed {
    if (![_currentNumber isEqualToString:@""] && ![_currentNumber isEqualToString:@"0"]) {
        NSLog(@"inversion act");
        NSDecimalNumber *inver = [NSDecimalNumber decimalNumberWithString:_currentNumber];
        NSDecimalNumber *tem = [NSDecimalNumber decimalNumberWithString:@"-1"];
        inver = [inver decimalNumberByMultiplyingBy:tem];
        
        NSMutableString *temDisplay = [NSMutableString stringWithString:_mainLabel.text];
        NSRange temRange = [temDisplay rangeOfString:_currentNumber];
        [temDisplay replaceCharactersInRange:temRange
                                  withString:[inver stringValue]];
        _mainLabel.text = [NSString stringWithString:temDisplay];
        
        [self setCurrentNumber:(NSMutableString *)[inver stringValue]];
        
        NSLog(@"%@", _currentNumber);
    }
}


- (void) enterPressed {
    //若有operation
    if ([_doCalculate rightOperandEmpty]) {
        
        //set right
        [_doCalculate setRightOperand:_currentNumber];
        [_doCalculate setRightOperandEmpty:NO];
        
        //reset current number
        [self setCurrentNumber:(NSMutableString *)@""];
        
        //set dotExist
        //???
        [self setDotExist:NO];
        
        //run operation
        [_doCalculate runOperation:_currentNumber];
        
        //display result
//        displayLabel3.text = [NSString stringWithString:displayLabel2.text];
//        displayLabel2.text = [NSString stringWithString:displayLabel.text];
//        displayLabel.text = [NSString stringWithFormat:@""];
//        displayLabel.text = [NSString stringWithString:[_doCalculate leftOperand]];
//        displayLabel.text = [displayLabel.text stringByAppendingString:@" "];
//        displayLabel.text = [displayLabel.text stringByAppendingString:[_doCalculate operation]];
//        displayLabel.text = [displayLabel.text stringByAppendingString:@" "];
//        displayLabel.text = [displayLabel.text stringByAppendingString:[_doCalculate rightOperand]];
//        displayLabel.text = [displayLabel.text stringByAppendingString:@" = "];
//        displayLabel.text = [displayLabel.text stringByAppendingString:[_doCalculate.result stringValue]];
        //displayLabel.text = [NSString stringWithString:[_doCalculate.result stringValue]];
        _mainLabel.text = [NSString stringWithString:[_doCalculate.result stringValue]];
        
        //reset everything
        [_doCalculate setOperation:@""];
        [_doCalculate setLeftOperand:[NSString stringWithFormat:@""]];
        [_doCalculate setRightOperand:[NSString stringWithFormat:@""]];
        [_doCalculate setLeftOperandEmpty:YES];
        [_doCalculate setRightOperandEmpty:YES];
        [_doCalculate setOperationEmpty:YES];
        
        [self setCurrentNumber:(NSMutableString *)[_doCalculate.result stringValue]];
        
        [self setJustDone:YES];
    }
}

- (IBAction)operationPressed:(UIButton *)sender {
    NSString *operation = sender.currentTitle;
    if ([operation isEqualToString:@"="]) {
        if (![_doCalculate leftOperandEmpty] && ![_currentNumber isEqualToString:@""]) {
            if (![_doCalculate operationEmpty]) {
                [self enterPressed];
            }
        }
    }
    else if ([operation isEqualToString:@"+"] ||
             [operation isEqualToString:@"-"] ||
             [operation isEqualToString:@"*"] ||
             [operation isEqualToString:@"/"]) {
        //set left and set operation
        if ([_doCalculate leftOperandEmpty] && ![_currentNumber isEqualToString:@""]) {
            
            //set left
            [_doCalculate setLeftOperand:_currentNumber];
            [_doCalculate setLeftOperandEmpty:NO];
            
            //reset current number
            _currentNumber = [NSString stringWithFormat:@""];
            
            //reset dotExit
            [self setDotExist:NO];
            
            //add operation & display
            if ([_doCalculate operationEmpty]) {
                //displayLabel.text = [displayLabel.text stringByAppendingString:operation];
                _mainLabel.text = [_mainLabel.text stringByAppendingString:operation];
                NSLog(@"no operation");
                [_doCalculate setOperation:operation];
                [_doCalculate setOperationEmpty:NO];
                
                NSLog(@"onetonine: %@", [_doCalculate operation]);
                NSLog(@"onetonine: %d", [_doCalculate operationEmpty]);
            }
            
            if ([self justDone]) {
                [self setJustDone:NO];
            }
        }
        //change operation
        else if (![_doCalculate leftOperandEmpty] && [_currentNumber isEqualToString:@""]) {
            if (![_doCalculate operationEmpty]) {
                //add operation & display
                //int temLength = [displayLabel.text length];
                //NSString *temString = [NSString stringWithString:[displayLabel.text substringToIndex:temLength - 1]];
                int temLength = [_mainLabel.text length];
                NSString *temString = [NSString stringWithString:[_mainLabel.text substringToIndex:temLength - 1]];
                
                temString = [temString stringByAppendingString:operation];
                //displayLabel.text = [NSString stringWithString:temString];
                _mainLabel.text = [NSString stringWithString:temString];
                NSLog(@"hv operation, add operation");
                [_doCalculate setOperation:operation];
                [_doCalculate setOperationEmpty:NO];
            }
        }
        //run operation and set naxt operation
        else if (![_doCalculate leftOperandEmpty] && ![_currentNumber isEqualToString:@""]) {
            if (![_doCalculate operationEmpty]) {
                [self enterPressed];
                [self setJustDone:NO];
                if ([_doCalculate leftOperandEmpty] && ![_currentNumber isEqualToString:@""]) {
                    
                    //set left
                    [_doCalculate setLeftOperand:_currentNumber];
                    [_doCalculate setLeftOperandEmpty:NO];
                    
                    //reset current number
                    _currentNumber = [NSString stringWithFormat:@""];
                    
                    //reset dotExit
                    //???
                    [self setDotExist:NO];
                    
                    //add operation & display
                    if ([_doCalculate operationEmpty]) {
                        //displayLabel.text = [displayLabel.text stringByAppendingString:operation];
                        _mainLabel.text = [_mainLabel.text stringByAppendingString:operation];
                        NSLog(@"run operation and no operation");
                        [_doCalculate setOperation:operation];
                        [_doCalculate setOperationEmpty:NO];
                        
                        NSLog(@"onetonine: %@", [_doCalculate operation]);
                        NSLog(@"onetonine: %d", [_doCalculate operationEmpty]);
                    }
                }
            }
        }
    }
    else if ([operation isEqualToString:@"inver"]) {
        [self inverPressed];
    }
    
}


#pragma mark -
#pragma mark Add Button、 _mainLabel、 4 labels
- (void)addButton {
    UIButton *_button = [UIButton new];
    //add button 1 to 9
    for (int i = 1; i <= 3; i++) {
        for (int j = 1; j <= 3; j++) {            
            int x = 20 + (buttonWidth + gap) * (i - 1);
            int y = 460 - 20 - (buttonHeight + gap) - buttonHeight * j - gap * (j - 1);
            int title = (j - 1) * 3 + i;
            _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [_button setFrame:CGRectMake( x, y, buttonWidth, buttonHeight)];
            [_button setTitle:[NSString stringWithFormat:@"%d", title]
                     forState:UIControlStateNormal];
            [_button setTag:(j - 1) * 3 + i];//tag1 to tag9
            [self.view addSubview:_button];
        }
    }
    
    //add button 0
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(20, 400, buttonWidth * 2 + gap, buttonHeight)];
    [_button setTitle:@"0" forState:UIControlStateNormal];
    [_button setTag:tag0];
    [self.view addSubview:_button];
    
    //add button .
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(20 + (buttonWidth + gap) * 2, 400, buttonWidth, buttonHeight)];
    [_button setTitle:@"." forState:UIControlStateNormal];
    [_button setTag:tagD];
    [self.view addSubview:_button];
    
    //add button =
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(20 + (buttonWidth + gap) * 3 ,
                                 400 - (buttonHeight + gap), buttonWidth, buttonHeight * 2 + gap)];
    [_button setTitle:@"=" forState:UIControlStateNormal];
    [_button setTag:tagE];
    [self.view addSubview:_button];
    
    //add button +
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(20 + (buttonWidth + gap) * 3 ,
                                 400 - (buttonHeight + gap) * 2, buttonWidth, buttonHeight)];
    [_button setTitle:@"+" forState:UIControlStateNormal];
    [_button setTag:tagE];
    [self.view addSubview:_button];
    
    //add button -
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(20 + (buttonWidth + gap) * 3 ,
                                 400 - (buttonHeight + gap) * 3, buttonWidth, buttonHeight)];
    [_button setTitle:@"-" forState:UIControlStateNormal];
    [_button setTag:tagS];
    [self.view addSubview:_button];
    
    //add button *
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(20 + (buttonWidth + gap) * 3 ,
                                 400 - (buttonHeight + gap) * 4, buttonWidth, buttonHeight)];
    [_button setTitle:@"*" forState:UIControlStateNormal];
    [_button setTag:tagM];
    [self.view addSubview:_button];
    
    //add button /
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(20 + (buttonWidth + gap) * 2 ,
                                 400 - (buttonHeight + gap) * 4, buttonWidth, buttonHeight)];
    [_button setTitle:@"/" forState:UIControlStateNormal];
    [_button setTag:tagDi];
    [self.view addSubview:_button];
    
    //add button ±
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(20 + (buttonWidth + gap) ,
                                 400 - (buttonHeight + gap) * 4, buttonWidth, buttonHeight)];
    [_button setTitle:@"±" forState:UIControlStateNormal];
    [_button setTag:tagIv];
    [self.view addSubview:_button];
    
    //add button Clear
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(20,
                                 400 - (buttonHeight + gap) * 4, buttonWidth, buttonHeight)];
    [_button setTitle:@"C" forState:UIControlStateNormal];
    [_button setTag:tagC];
    [self.view addSubview:_button];
    
    [self setButton];
}

- (void)setButton {
    _button1 = (UIButton *)[self.view viewWithTag:tag1];
    [_button1 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _button2 = (UIButton *)[self.view viewWithTag:tag2];
    [_button2 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _button3 = (UIButton *)[self.view viewWithTag:tag3];
    [_button3 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _button4 = (UIButton *)[self.view viewWithTag:tag4];
    [_button4 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _button5 = (UIButton *)[self.view viewWithTag:tag5];
    [_button5 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _button6 = (UIButton *)[self.view viewWithTag:tag6];
    [_button6 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _button7 = (UIButton *)[self.view viewWithTag:tag7];
    [_button7 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _button8 = (UIButton *)[self.view viewWithTag:tag8];
    [_button8 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _button9 = (UIButton *)[self.view viewWithTag:tag9];
    [_button9 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _button0 = (UIButton *)[self.view viewWithTag:tag0];
    [_button0 addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _buttonD = (UIButton *)[self.view viewWithTag:tagD];
    [_buttonD addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _buttonE = (UIButton *)[self.view viewWithTag:tagE];
    [_buttonE addTarget:self action:@selector(operationPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _buttonA = (UIButton *)[self.view viewWithTag:tagA];
    [_buttonA addTarget:self action:@selector(operationPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _buttonS = (UIButton *)[self.view viewWithTag:tagS];
    [_buttonS addTarget:self action:@selector(operationPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _buttonM = (UIButton *)[self.view viewWithTag:tagM];
    [_buttonM addTarget:self action:@selector(operationPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _buttonDi = (UIButton *)[self.view viewWithTag:tagDi];
    [_buttonDi addTarget:self action:@selector(operationPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _buttonC = (UIButton *)[self.view viewWithTag:tagC];
    [_buttonC addTarget:self action:@selector(digitPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _buttonIv = (UIButton *)[self.view viewWithTag:tagIv];
    [_buttonIv addTarget:self action:@selector(operationPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addMailLabel {
    _mainLabel = [UILabel new];
    [_mainLabel setFrame:CGRectMake(20, 400 - (buttonHeight + gap) * 4 - gap - displayHeight, 280, displayHeight)];
    [_mainLabel setText:@"here i am"];
    [self.view addSubview:_mainLabel];
    
    [self addLabel];
}

- (void)addLabel {
    _label1 = [UILabel new];
    [_label1 setFrame:CGRectMake(20, 110, 280, 25)];
    [_label1 setText:@"label1"];
    [self.view addSubview:_label1];
    
    _label2 = [UILabel new];
    [_label2 setFrame:CGRectMake(20, 80, 280, 25)];
    [_label2 setText:@"labbel2"];
    [self.view addSubview:_label2];
    
    _label3 = [UILabel new];
    [_label3 setFrame:CGRectMake(20, 50, 280, 25)];
    [_label3 setText:@"label3"];
    [self.view addSubview:_label3];
    
    _label4 = [UILabel new];
    [_label4 setFrame:CGRectMake(20, 20, 280, 25)];
    [_label4 setText:@"label 4"];
    [self.view addSubview:_label4];
}

@end
