//
//  PresentVC.m
//  PresentVCDemo
//
//  Created by chen on 15/12/22.
//  Copyright © 2015年 chen. All rights reserved.
//

#import "PresentVC.h"
#import "CCLModalTransition.h"

@interface PresentVC ()<UIViewControllerTransitioningDelegate>

@end

@implementation PresentVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor brownColor];
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CCLModalTransition transitionWithType:kCCLModalTransitionPresent duration:0.5 presentHeight:350 scale:CGPointMake(0.9, 0.98)];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [CCLModalTransition transitionWithType:KCCLModalTransitionDismiss duration:0.5 presentHeight:350 scale:CGPointMake(0.9, 0.98)];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
