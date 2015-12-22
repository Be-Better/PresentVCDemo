//
//  CCLModalTransition.h
//  PresentVCDemo
//
//  Created by chen on 15/12/22.
//  Copyright © 2015年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CCLModalTransitionType) {
    kCCLModalTransitionPresent = 1 << 1,
    KCCLModalTransitionDismiss = 1 << 2
};

@interface CCLModalTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (CCLModalTransition *)transitionWithType:(CCLModalTransitionType)type duration:(NSTimeInterval)duration presentHeight:(CGFloat)presentHeight scale:(CGPoint)scale;

@end
