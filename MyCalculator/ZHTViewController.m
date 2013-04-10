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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self addButton];
    [self setButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark AddButtonAndTextView
- (void)addButton {
    UIButton *_button = [[UIButton alloc] init];
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
}

- (void)setButton {
    _button1 = (UIButton *)[self.view viewWithTag:tag1];
    _button2 = (UIButton *)[self.view viewWithTag:tag2];
    _button3 = (UIButton *)[self.view viewWithTag:tag3];
    _button4 = (UIButton *)[self.view viewWithTag:tag4];
    _button5 = (UIButton *)[self.view viewWithTag:tag5];
    _button6 = (UIButton *)[self.view viewWithTag:tag6];
    _button7 = (UIButton *)[self.view viewWithTag:tag7];
    _button8 = (UIButton *)[self.view viewWithTag:tag8];
    _button9 = (UIButton *)[self.view viewWithTag:tag9];
    _button0 = (UIButton *)[self.view viewWithTag:tag0];
    _buttonD = (UIButton *)[self.view viewWithTag:tagD];
    _buttonE = (UIButton *)[self.view viewWithTag:tagE];
    _buttonA = (UIButton *)[self.view viewWithTag:tagA];
    _buttonS = (UIButton *)[self.view viewWithTag:tagS];
    _buttonM = (UIButton *)[self.view viewWithTag:tagM];
    _buttonDi = (UIButton *)[self.view viewWithTag:tagDi];
    _buttonC = (UIButton *)[self.view viewWithTag:tagC];
    _buttonIv = (UIButton *)[self.view viewWithTag:tagIv];
}

@end
