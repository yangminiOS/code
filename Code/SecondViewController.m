//
//  SecondViewController.m
//  Code
//
//  Created by mini on 2018/1/5.
//  Copyright © 2018年 mini. All rights reserved.
//

#import "SecondViewController.h"

#import "YMCodeView.h"

@interface SecondViewController ()

@property (nonatomic, strong)YMCodeView *codeView;

@end


@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    
    YMCodeView *codeView = [[YMCodeView alloc] initWithFrame:frame];
    
    self.codeView = codeView;
    
    [self.view addSubview:codeView];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.codeView registFirst];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
