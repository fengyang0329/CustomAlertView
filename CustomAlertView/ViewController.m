//
//  ViewController.m
//  CustomAlertView
//
//  Created by 龙章辉 on 15/11/27.
//  Copyright © 2015年 Peter. All rights reserved.
//

#import "ViewController.h"
#import "YWAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btn];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[btn]-60-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[btn(60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn)]];

}
- (void)show
{
    NSString *title = @"这是现代战争深山老林";
    NSString *message = @"这是现代战争深山老林kkgksgksgksghskg口杯hskghkhgksghksgskhgskh这是现代战争深山老林kkgksgksgksghskg口杯hskghkhgksghksgskhgskh";
//    title = @"";
//    message = @"";
//    YWAlertView *alert = [[YWAlertView alloc] initWithTitle:title message:message  delegate:self buttonTitles:@"a",@"b",@"c",nil];
    YWAlertView *alert = [[YWAlertView alloc] initWithTitle:title message:message  delegate:self buttonTitles:@"a",@"b",nil];
    [alert show];
    
//    [alert setButtonTitlesColor:[UIColor purpleColor],[UIColor greenColor]];
//    [alert setbuttonTitleColor:[UIColor blackColor] WithIndex:2];
//    [alert setButtonTitlesFont:[UIFont systemFontOfSize:16.0],[UIFont systemFontOfSize:28.0]];
//    [alert setbuttonTitleFont:[UIFont boldSystemFontOfSize:30] WithIndex:2];
}

#pragma mark YWAlertViewDelegate
- (void)alertView:(YWAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex:%zi",buttonIndex);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
