//
//  ViewController.m
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "AppDelegate.h"

@class AppDelegate;

@interface ViewController ()

@end

@implementation ViewController

// ------------------------------------------------------
// INIT FUNCTION
// ------------------------------------------------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // [self.view setBackgroundColor:[UIColor redColor]];
    
    // old way + new way
    float x, y, w, h;
    w = self.view.frame.size.width;
    h = self.view.frame.size.height;
    x = 0;
    y = (h - w) / 2;
    
    // new way only
//    CGRect dotArea = CGRectMake(w/2,h/2, w/100, w/100);
//    dotView = [[DotView alloc] initWithFrame:dotArea];
//    [self.view addSubview: dotView];
//    cycles = 3600;
//    fps = 30.0;
//    [self animateDot];
    
    // old way only
    julesArea = CGRectMake(x, y, w, w);
    [self startAnimation];
    [self initTimer];
}


// ------------------------------------------------------
// OLD WAY FUNCTIONS
// ------------------------------------------------------

// public methods
- (void) enterBackground
{
    [julesTimer invalidate];
    [julesView removeFromSuperview];
    
    // i think this causes the timer and view to be released from memory?
    julesTimer = nil;
    julesView = nil;
}

- (void) enterForeground
{
    [self startAnimation];
    [self initTimer];
}

// private methods
- (void) startAnimation
{
    julesView = [[JulesView alloc] initWithFrame:julesArea];
    julesView.clearsContextBeforeDrawing = NO;
    [self.view addSubview: julesView];
//    dotView = [[DotView alloc] initWithFrame:julesArea];
//    dotView.clearsContextBeforeDrawing = NO;
//    [self.view addSubview: dotView];
    counter = 0;
}

- (void) initTimer
{
    julesTimer = [NSTimer
                    scheduledTimerWithTimeInterval:1.f/30.f
                    target:self
                    selector:@selector(julesTimerCallBack)
                    userInfo:nil
                    repeats:YES
                  ];
    
    [[NSRunLoop currentRunLoop]
        addTimer:julesTimer
        forMode:NSDefaultRunLoopMode
    ];
    

}

- (void) julesTimerCallBack
{
    if(counter > 3600)
    {
        [julesView removeFromSuperview];
        [self startAnimation];
    }
    else
    {
        dp2 = dp1;
        [julesView setNeedsDisplay];
        // [dotView setNeedsDisplay];
        dp1 = [julesView dotPoint];
        float speed = (sqrt(powf((dp2.x - dp1.x), 2.0) + powf((dp2.y - dp1.y), 2.0)))*30.0;
        self.speedLabel.text = [NSString stringWithFormat:@"%1.4f", speed];
        self.posLabel.text = [NSString stringWithFormat:@"(%1.0f, %1.0f)", dp1.x, dp1.y];
        self.timeLabel.text = [NSString stringWithFormat:@"00:%05.2f", counter / 30.0];
        counter++;
    }

}

// ------------------------------------------------------
// NEW WAY FUNCTIONS
// ------------------------------------------------------

// so this works, but it is SO HORRIBLY HACKY
- (void) animateDot
{
    // remove old path from layer
    [pathLayer removeFromSuperlayer];
    // make a new path
    [self makePath];
    // make a new drawing of that path
    [self makePathLayer];
    // add new path to layer
    [self.view.layer addSublayer:pathLayer];
    // set duration
    float d = cycles / fps;
    
    // i'm not even sure this should be in an animation block? but apple seem
    // so insistent on you using animation blocks in place of callbacks and UGH
    // also how are you even supposed to align this mess?
    [UIView animateWithDuration:d
            delay:0.0
            options:0
            animations:^
            {
                 // these changes to the dotView's alpha serve no
                 // purpose visually -- they are only necessary here
                 // because i don't know how to tie this animation
                 // block's timing to the CABasicAnimation instead of
                 // the 'animation' of this dummy dotView
                 dotView.alpha = 0.0;
                 dotView.alpha = 0.5;
                 
                 CABasicAnimation *anim;
                 anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                 anim.fromValue = [NSNumber numberWithFloat:0.0f];
                 anim.toValue = [NSNumber numberWithFloat:1.0f];
                 anim.duration = d;
                 [pathLayer addAnimation:anim forKey:@"strokeEnd"];
            }
            completion:^(BOOL finished)
            {
                [self animateDot];
            }
     ];
}

// make a global CGPath for use in [self makePathLayer]
- (void) makePath
{
//    float x, y, xFactor, yFactor, theta, delta, scalar;
//    CGSize size = self.view.frame.size;
//    path = CGPathCreateMutable();
//    
//    srand48(time(0));
//    xFactor = (float)drand48() * 2.f;
//    yFactor = (float)drand48() * 2.f;
//    theta = 0.0;
//    delta = 0.035;
//    scalar = size.width / 2.2;
//    
//    x = scalar * (sin(xFactor*theta)) + size.width / 2.0;
//    y = scalar * (sin(yFactor*theta)) + size.height / 2.0;
//    CGPathMoveToPoint(path, NULL, x, y);
//    for(int i = 0; i < cycles; i++)
//    {
//        CGPathAddLineToPoint(path, NULL, x, y);
//        theta += delta;
//        x = scalar * (sin(xFactor*theta)) + size.width / 2.0;
//        y = scalar * (sin(yFactor*theta)) + size.height / 2.0;
//    }
}

// make a global CAShapeLayer for use in [self animateDot]
- (void) makePathLayer
{
    // is this check necessary? can we just make a new CAShapeLayer
    // each time and let ARC clean up the mess?
    if(!pathLayer)
        pathLayer = [CAShapeLayer layer];
    
    pathLayer.frame = self.view.bounds;
    pathLayer.path = path;
    pathLayer.strokeColor = [[UIColor redColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 3.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    pathLayer.lineCap = kCALineCapRound;
    
    // possibly a way to make the dots appear, but also possibly
    // not because no way to reflect speed of the drawing
    // (that i can think of)
    // pathLayer.lineDashPattern = @[@1,@5];

}


// ------------------------------------------------------
// MISCELLANEOUS FUNCTIONS
// ------------------------------------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
