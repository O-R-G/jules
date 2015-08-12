//
//  ViewController.m
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@class AppDelegate;

@interface ViewController ()

@end

@implementation ViewController

// BOOL
@synthesize varsShown;

// int
@synthesize counter;

// float
@synthesize xFactor;
@synthesize yFactor;
@synthesize theta;

// CGSize
@synthesize size;

// CGFloat
@synthesize scalar;

// CGPoint
@synthesize dotPoint;
@synthesize dp2;

// CGRect
@synthesize dotRect;
@synthesize julesArea;

// CAShapeLayer
@synthesize shapeLayer;

// NSMutableArray
@synthesize shapeLayers;

// NSTimer
@synthesize julesTimer;

// UIBezierPath
@synthesize path;



// ------------------------------------------------------
// INIT FUNCTION
// ------------------------------------------------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = self;

    CGFloat dotSize;
    float x, y, w, h;
    w = self.view.frame.size.width;
    h = self.view.frame.size.height;
    x = 0;
    y = (h - w) / 2;
    julesArea = CGRectMake(x, y, w, w);
    varsShown = NO;
    
    // CGSize
    size = julesArea.size;
    
    // CGFloat
    scalar = size.width / 2.2f;
    dotSize = size.width / 100.f;
    
    // CGRect
    dotRect.size = CGSizeMake(dotSize, dotSize);
    
    [self startAnimation];
    [self initTimer];
}

// public methods
- (void) enterBackground
{
    [julesTimer invalidate];
    [shapeLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    // i think this causes the timer to be released from memory?
    julesTimer = nil;
}

- (void) enterForeground
{
    [self startAnimation];
    [self initTimer];
}

// private methods
- (void) startAnimation
{
    srand48(time(0));
    
    // float
    theta = 0.035;
    xFactor = (float)drand48() * 2.f;
    yFactor = (float)drand48() * 2.f;

    // CGPoint
    dotPoint.x = scalar * (sin(xFactor*theta) + size.width / 2);
    dotPoint.y = scalar * (sin(yFactor*theta) + size.height / 2);
    
    shapeLayers = [[NSMutableArray alloc] init];
    counter = 0;
}

- (void) drawFrame
{
    dotRect.origin = dotPoint;
    path = [UIBezierPath bezierPathWithOvalInRect:dotRect];
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = julesArea;
    shapeLayer.fillColor = [[UIColor redColor] CGColor];
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    [shapeLayers addObject:shapeLayer];
    
    // update values for next frame
    theta += 0.035;
    dotPoint.x = scalar * (sin(xFactor*theta)) + size.width / 2;
    dotPoint.y = scalar * (sin(yFactor*theta)) + size.height / 2;
    counter++;
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
        [shapeLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self startAnimation];
    }
    else
    {
        dp2 = dotPoint;
        [self drawFrame];
        [self updateLabels];
    }

}

- (void) updateLabels
{
    float speed = (sqrt(powf((dp2.x - dotPoint.x), 2.0) + powf((dp2.y - dotPoint.y), 2.0)))*30.0;
    self.posLabel.text = [NSString stringWithFormat:@"(%1.0f, %1.0f)", dotPoint.x, dotPoint.y];
    self.timeLabel.text = [NSString stringWithFormat:@"00:%05.2f", counter / 30.0];
    self.speedLabel.text = [NSString stringWithFormat:@"%1.4f", speed];
}

// ------------------------------------------------------
// MISCELLANEOUS FUNCTIONS
// ------------------------------------------------------

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void) takeScreenshot
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(window.bounds.size);
    
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    NSData* imageData =  UIImagePNGRepresentation(image);
    UIImage* pngImage = [UIImage imageWithData:imageData];
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil);
    
    // flash the screen
    UIView *flashView = [[UIView alloc] initWithFrame:window.bounds];
    flashView.backgroundColor = [UIColor whiteColor];
    flashView.alpha = 1.0f;
    [window addSubview:flashView];
    
    [UIView
     animateWithDuration:0.5f
     animations:^
     {
         flashView.alpha = 0.0f;
     }
     completion:^(BOOL finished)
     {
         [flashView removeFromSuperview];
     }
     ];
}

// ------------------------------------------------------
// ACTIONS
// ------------------------------------------------------

- (IBAction)longPressAction:(UILongPressGestureRecognizer *)sender
{
    if(sender.state == UIGestureRecognizerStateBegan)
        [self takeScreenshot];
}

- (IBAction)doubleTapAction:(UITapGestureRecognizer *)sender
{
    [self takeScreenshot];
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender
{
    if(varsShown)
    {
        self.posLabel.hidden = YES;
        self.timeLabel.hidden = YES;
        self.speedLabel.hidden = YES;
        varsShown = NO;
    }
    else
    {
        self.posLabel.hidden = NO;
        self.timeLabel.hidden = NO;
        self.speedLabel.hidden = NO;
        varsShown = YES;
    }
}

@end
