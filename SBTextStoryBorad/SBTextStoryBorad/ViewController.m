//
//  ViewController.m
//  SBTextStoryBorad
//
//  Created by qyb on 2017/7/6.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ViewController.h"
#import "SBTextStoryBoard.h"
#import "SBTextContent.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SBTextStoryBoard *textBoard = [[SBTextStoryBoard alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    textBoard.lineSpacing = 30.f;
    textBoard.paragraphSpacing = 50.f;
//    textBoard.fontSpacing = 10.f;
    textBoard.textAlignment = NSTextAlignmentCenter;
    textBoard.contentChain = [SBTextContent textContent].sbtext(@"现在开始测试了，大家卡清楚是什么情况吧现在开始测试了，大家卡清楚是\n什么情况吧现在开始测试了，大家卡清楚是什么情况吧现在开始测试了，大家卡清楚是什么情况吧",[UIColor blueColor],[UIFont systemFontOfSize:14],nil).sbbrline().sblink(@"http://2222222",[UIColor redColor],nil);
    [self.view addSubview:textBoard];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
