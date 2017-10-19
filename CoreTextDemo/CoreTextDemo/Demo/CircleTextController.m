//
//  CircleTextController.m
//  CoreTextDemo
//
//  Created by hanfeng.li on 2017/10/18.
//  Copyright © 2017年 hanfeng.li. All rights reserved.
//

#import "CircleTextController.h"
#import "CircleLabel.h"

@interface CircleTextController ()
@property (strong, nonatomic)  CircleLabel *circleLabel;
@end

@implementation CircleTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.circleLabel.text = @"CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版";
}

- (CircleLabel *)circleLabel  {
    if (!_circleLabel) {
        float width = [UIScreen mainScreen].bounds.size.width;
        _circleLabel = [[CircleLabel alloc] initWithFrame:CGRectMake(0, 100, width, 200)];
        _circleLabel.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_circleLabel];
    }
    return _circleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
