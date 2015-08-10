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
    
    // old (redraw view) variables
    JulesView *julesView;
    NSTimer *julesTimer;
    CGRect julesArea;
    int counter;
//    float xFactor, yFactor, theta, alpha;
//    CGSize size;
//    CGFloat scalar, dotSize;
//    CGPoint dotPoint, dotPointPrevious;
    
    // new (core animation) variables
    DotView *dotView;
    CGMutablePathRef path;
    CAShapeLayer *pathLayer;
    int cycles;
    float fps;
}

// @property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *posLabel;

// public methods
- (void) enterBackground;
- (void) enterForeground;

- (void) animateDot;
- (void) makePath;
- (void) makePathLayer;

@end

