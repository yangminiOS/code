//
//  ViewController.m
//  Code
//
//  Created by mini on 2017/12/27.
//  Copyright © 2017年 mini. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "YMCodeView.h"
#import "SecondViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    
    //YMCodeView *codeView = [[YMCodeView alloc] initWithFrame:frame];
    
    //[self.view addSubview:codeView];
   
}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//
//    if(textField.text.length==4) [textField resignFirstResponder];
//
//    return YES;
//}

- (IBAction)clickNextButton:(UIButton *)sender {
    SecondViewController  *secong = [[SecondViewController alloc] init];
    
    [self.navigationController pushViewController:secong animated:YES];
    
}



@end
