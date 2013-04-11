//
//  ZHTViewController.h
//  MyCalculator
//
//  Created by zht on 13-4-9.
//  Copyright (c) 2013年 zht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "ZHTDoCalculate.h"

@interface ZHTViewController : UIViewController

@property (retain, nonatomic)UIButton *button1;
@property (retain, nonatomic)UIButton *button2;
@property (retain, nonatomic)UIButton *button3;
@property (retain, nonatomic)UIButton *button4;
@property (retain, nonatomic)UIButton *button5;
@property (retain, nonatomic)UIButton *button6;
@property (retain, nonatomic)UIButton *button7;
@property (retain, nonatomic)UIButton *button8;
@property (retain, nonatomic)UIButton *button9;
@property (retain, nonatomic)UIButton *button0;
@property (retain, nonatomic)UIButton *buttonD;
@property (retain, nonatomic)UIButton *buttonE;
@property (retain, nonatomic)UIButton *buttonA;
@property (retain, nonatomic)UIButton *buttonS;
@property (retain, nonatomic)UIButton *buttonM;
@property (retain, nonatomic)UIButton *buttonDi;
@property (retain, nonatomic)UIButton *buttonC;
@property (retain, nonatomic)UIButton *buttonIv;

@property (retain, nonatomic)UILabel *mainLabel;
@property (retain, nonatomic)UILabel *label1;
@property (retain, nonatomic)UILabel *label2;
@property (retain, nonatomic)UILabel *label3;
@property (retain, nonatomic)UILabel *label4;

@property (retain, nonatomic)ZHTDoCalculate *doCalculate;
@property (retain, nonatomic)NSMutableString *currentNumber;
@property (assign, nonatomic)BOOL dotExist;
@property (assign, nonatomic)BOOL justDone;
@property (assign, nonatomic)int displayCount;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;


@end
