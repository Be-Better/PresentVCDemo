//
//  CCLModalTransition.m
//  PresentVCDemo
//
//  Created by chen on 15/12/22.
//  Copyright © 2015年 chen. All rights reserved.
//

#import "CCLModalTransition.h"
#import "UIView+anchorPoint.h"

@interface CCLModalTransition() 

@property (nonatomic, assign) CCLModalTransitionType type;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) CGFloat presentHeight;
@property (nonatomic, assign) CGPoint scale;


@end

@implementation CCLModalTransition

+ (CCLModalTransition *)transitionWithType:(CCLModalTransitionType)type duration:(NSTimeInterval)duration presentHeight:(CGFloat)presentHeight scale:(CGPoint)scale {
    
    CCLModalTransition * transition = [[CCLModalTransition alloc]init];
    transition.type = type;
    transition.duration = duration;
    transition.presentHeight = presentHeight;
    transition.scale = scale;
    return transition;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.type) {
        case kCCLModalTransitionPresent:
            [self present:transitionContext];
            break;
        case KCCLModalTransitionDismiss:
            [self dismiss:transitionContext];
            break;
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    
    //截取图像
    UIView * tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    [tempView setAnchorPointTo:CGPointMake(0.5, 1)];
    
    fromVC.view.hidden = YES;
    //实现专场，必须加入到containerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.bounds.size.width, self.presentHeight);
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.duration animations:^{
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -weakSelf.presentHeight);
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/500.0;
        tempView.layer.transform = CATransform3DRotate(transform, M_PI_4 / 11, 1, 0, 0);
        tempView.transform = CGAffineTransformMakeScale(weakSelf.scale.x, weakSelf.scale.y);
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:YES];
        }
    }];
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    
    UIView * tempView = containerView.subviews.lastObject;
    UIView * shotView = containerView.subviews.firstObject;
    [shotView setAnchorPointTo:CGPointMake(0.5, 1)];
    
    [UIView animateWithDuration:self.duration animations:^{
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0 / 500.0;
        shotView.layer.transform = CATransform3DRotate(transform, M_PI_4 / 11, 1, 0, 0);
        shotView.transform = CGAffineTransformMakeScale(1, 1);
        
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            
            [shotView removeFromSuperview];
            [tempView removeFromSuperview];
        }
    }];
}

@end
