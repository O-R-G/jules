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
    CGPoint dp1, dp2;
    
    // new (core animation) variables
    DotView *dotView;
    CGMutablePathRef path;
    CAShapeLayer *pathLayer;
    int cycles;
    float fps;
}

// @property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *posLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *speedLabel;


// public methods
- (void) enterBackground;
- (void) enterForeground;

- (void) animateDot;
- (void) makePath;
- (void) makePathLayer;

@end

