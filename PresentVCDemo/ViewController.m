//
//  ViewController.m
//  PresentVCDemo
//
//  Created by chen on 15/12/22.
//  Copyright © 2015年 chen. All rights reserved.
//

#import "ViewController.h"
#import "PresentVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PresentVC * presentView = [[PresentVC alloc]init];
    [self presentViewController:presentView animated:YES completion:nil];
}

@end
