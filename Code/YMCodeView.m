//
//  YMCodeView.m
//  Code
//
//  Created by mini on 2018/1/4.
//  Copyright © 2018年 mini. All rights reserved.
//

#import "YMCodeView.h"
#import <Masonry.h>
#import <ReactiveObjC.h>
#define kNomalColor  [UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1.0]
#define kSelectColor [UIColor colorWithRed:245.0/255 green:106.0/255 blue:32.0/255 alpha:1.0]

static NSInteger count = 5;

static CGFloat itemW = 30;
static CGFloat lineH = 1;

static CGFloat margin = 20;

@interface YMCodeView()<UITextFieldDelegate>
@property (nonatomic, strong)NSMutableArray *fieldArray;

@property (nonatomic, strong)NSMutableArray *codeArray;

@property (nonatomic, strong)NSMutableArray *lineArray;

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UITextField *textField;

@property (nonatomic, assign)NSInteger  index;

@property (nonatomic, assign)BOOL  isLastFill;

@property (nonatomic, copy)NSString *inputString;

@end

@implementation YMCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self setupUI];
    }
    
    return self;
}



- (void)setupUI{
    
    self.inputString = @"";
    
    CGFloat bigMargin = (self.frame.size.width - (itemW*5 + margin *4))/2;
    
    for (NSInteger i = 0; i<5; i++) {
        
        UITextField *field = [[UITextField alloc] init];
        field.textAlignment = NSTextAlignmentCenter;
        [self addSubview:field];
        field.keyboardType = UIKeyboardTypeNumberPad;
        field.delegate = self;
        field.enabled = NO;
        [[field rac_signalForSelector:NSSelectorFromString(@"deleteBackward")] subscribeNext:^(RACTuple * _Nullable x) {
            
            //如果是最后一个
            if(self.isLastFill ){
                self.textField.enabled = YES;
                [self.textField becomeFirstResponder];
                self.textField.text = @"";
                self.isLastFill = NO;
                
                self.inputString = [self.inputString substringToIndex:self.inputString.length -1];
                
                if([self.delegate respondsToSelector:@selector(YMCodeView:inputString:)]){
                    
                    [self.delegate YMCodeView:self inputString:self.inputString];
                }
                
            }else if(self.index >= 1){
                
                UIView *line =self.lineArray[self.index];
                line.backgroundColor = kNomalColor;
                
                self.textField.enabled = NO;
                self.textField = self.fieldArray[self.index - 1];
                self.lineView =self.lineArray[self.index -1];
                self.textField.enabled = YES;
                self.textField.text = @"";
                self.index --;
                [self.textField becomeFirstResponder];
                
                if(self.inputString.length >=1){
                    self.inputString = [self.inputString substringToIndex:self.inputString.length -1];
                    
                    if([self.delegate respondsToSelector:@selector(YMCodeView:inputString:)]){
                        
                        [self.delegate YMCodeView:self inputString:self.inputString];
                    }
                    
                } 
            }

        }];
        UIView *line = [[UIView alloc] init];
        [self addSubview:line];
        line.backgroundColor = kNomalColor;
        [self.fieldArray addObject:field];
        [self.lineArray addObject:line];
         [field addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    [self.fieldArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:margin leadSpacing:bigMargin tailSpacing:bigMargin];
    
    [self.fieldArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    [self.lineArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:margin leadSpacing:bigMargin tailSpacing:bigMargin];
    
    [self.lineArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(lineH);
        make.width.mas_equalTo(30);
    }];
    self.textField = self.fieldArray.firstObject;
    self.lineView  = self.lineArray.firstObject;
    
    [self.textField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];

    
}

- (void)textField1TextChange:(UITextField *)textField{
    
    if(textField.text.length > 0)self.textField.text = [textField.text substringToIndex:1];
    
    self.textField = [self.fieldArray objectAtIndex:_index];
    
 
    //NSLog(@"change index == %zd",self.index);
    self.textField.enabled = YES;
    textField.enabled = NO;
    [self.textField becomeFirstResponder];
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"=====%@  %@",string,textField.text);
    self.index = [self.fieldArray indexOfObject:textField];
    if(string.length>0){
        
        if(_index == (count -1)){
            
            self.inputString = [self.inputString stringByAppendingString:string];
            
            if([self.delegate respondsToSelector:@selector(YMCodeView:inputString:)]){
                
                [self.delegate YMCodeView:self inputString:self.inputString];
            }
            
            self.isLastFill = self.index == (count -1)?YES:NO;
        }
        
        if(_index >=0  && _index < (count -1)){
            self.index ++;
            UIView *line =self.lineArray[self.index];
            line.backgroundColor = kSelectColor;
            self.lineView = line;
            
            self.inputString = [self.inputString stringByAppendingString:string];
            
            if([self.delegate respondsToSelector:@selector(YMCodeView:inputString:)]){
                
                [self.delegate YMCodeView:self inputString:self.inputString];
            }
            
        }
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //[self.textField becomeFirstResponder];
    self.lineView.backgroundColor = kSelectColor;
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
//    [self.textField resignFirstResponder];
    //self.lineView.backgroundColor = kNomalColor;
    
    if(textField.text <=0){
        
        self.lineView.backgroundColor = kNomalColor;
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.textField.enabled = YES;
    
    [self.textField becomeFirstResponder];
    self.lineView.backgroundColor = kSelectColor;
    
}

- (void)becomeFirst{
    
    if(self.inputString.length >0){
        
        self.inputString = @"";
        
        for (NSInteger i = 0; i<count; i++) {
            
            UIView *line = self.lineArray[i];
            line.backgroundColor = kNomalColor;
            
            UILabel *label = self.fieldArray[i];
            label.text = @"";
            
        }
        self.textField = self.fieldArray.firstObject;
        self.lineView  = self.lineArray.firstObject;
    }
    
    self.textField.enabled = YES;
    [self.textField becomeFirstResponder];
    
    
}
- (void)registFirst{
    
    [self.textField resignFirstResponder];
    self.lineView.backgroundColor = kNomalColor;
}

//*************************get

- (NSMutableArray *)fieldArray{
    
    if(!_fieldArray) _fieldArray = [NSMutableArray array];
    
    return _fieldArray;
}

- (NSMutableArray *)lineArray{
    
    if(!_lineArray) _lineArray = [NSMutableArray array];
    
    return _lineArray;
}

@end
