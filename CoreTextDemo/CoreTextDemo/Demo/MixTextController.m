//
//  MixTextController.m
//  CoreTextDemo
//
//  Created by hanfeng.li on 2017/10/18.
//  Copyright © 2017年 hanfeng.li. All rights reserved.
//

#import "MixTextController.h"
#import "MixTextLabel.h"

@interface MixTextController ()
@property (weak, nonatomic) IBOutlet MixTextLabel *contentLabel;
@end

@implementation MixTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentLabel.text = @"CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版CoreText圆形排版";
    self.contentLabel.backgroundColor = [UIColor grayColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
