//
//  ViewController.h
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (readonly) BOOL varsShown;
@property (readonly) int counter;
@property (readonly) float xFactor;
@property (readonly) float yFactor;
@property (readonly) float theta;
@property (readonly) CGSize size;
@property (readonly) CGFloat scalar;
@property (readonly) CGPoint dotPoint;
@property (readonly) CGPoint dp2;
@property (readonly) CGRect dotRect;
@property (readonly) CGRect julesArea;
@property (readonly) CAShapeLayer *shapeLayer;
@property (readonly) NSMutableArray *shapeLayers;
@property (readonly) NSTimer *julesTimer;
@property (readonly) UIBezierPath *path;

@property (strong, nonatomic) IBOutlet UILabel *posLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *speedLabel;

- (IBAction)longPressAction:(UILongPressGestureRecognizer *)sender;
- (IBAction)doubleTapAction:(UITapGestureRecognizer *)sender;
- (IBAction)tapAction:(UITapGestureRecognizer *)sender;

// public methods
- (void) enterBackground;
- (void) enterForeground;

@end

