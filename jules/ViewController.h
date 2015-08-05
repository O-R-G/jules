//
//  ViewController.h
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JulesView.h"
#import "DotView.h"

@interface ViewController : UIViewController {
    JulesView *julesView;
    DotView *dotView;
    NSTimer *julesTimer;
    CADisplayLink *displayLink;
    CGMutablePathRef path;
    CAShapeLayer *pathLayer;
    int cycles;
    float fps;
}

- (void) initTimer;
- (void) julesTimerCallBack;
- (void) animateDot;

@end

