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

// int
@synthesize counter;
@synthesize orderOfMagnitude;

// float
@synthesize xFactor;
@synthesize yFactor;
@synthesize theta;
@synthesize dtheta;
@synthesize mHz;
@synthesize hzGranularity;
@synthesize frameRate;

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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.viewController = self;

    CGFloat dotSize;
    float x, y, w, h;
    w = self.view.frame.size.width;
    h = self.view.frame.size.height;
    x = 0;
    y = (h - w) / 2;
    julesArea = CGRectMake(x, y, w, w);
    frameRate = 30.f;
    dtheta = 1.f/frameRate;
    hzGranularity = 1000.f;
    orderOfMagnitude = -3;
    
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
    int g;
    
    // float
    theta = dtheta;
    xFactor = roundToN(drand48()*2.f, orderOfMagnitude) + pow(10, orderOfMagnitude);
    NSLog(@"%1.5f", xFactor);
    yFactor = roundToN(drand48()*2.f, orderOfMagnitude) + pow(10, orderOfMagnitude);
    NSLog(@"%1.5f", yFactor);
    g = gcf((int)(hzGranularity*xFactor), (int)(hzGranularity*yFactor));
    mHz = dtheta*frameRate*((float)g)/M_2_PI*pow(10, orderOfMagnitude);
    
    // CGPoint
    dotPoint.x = scalar * sin(xFactor*theta) + size.width / 2;
    dotPoint.y = scalar * sin(yFactor*theta) + size.height / 2;

    shapeLayers = [[NSMutableArray alloc] init];
    counter = 0;
}

- (void) drawFrame
{
    int g;
    
    dotRect.origin = dotPoint;
    path = [UIBezierPath bezierPathWithOvalInRect:dotRect];
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = julesArea;
    shapeLayer.fillColor = [[UIColor redColor] CGColor];
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    [shapeLayers addObject:shapeLayer];
    
    // update values for next frame
    theta += dtheta;
    dotPoint.x = scalar * sin(xFactor*theta) + size.width / 2;
    dotPoint.y = scalar * sin(yFactor*theta) + size.height / 2;
    
    /*
     * source: http://stackoverflow.com/questions/9620324/how-to-calculate-the-period-of-a-lissajous-curve
     
     * the frequency of the lissajous is GCF(xFactor, yFactor) / 2*PI
     * but, this is assuming that one second = one second, which is not always
     * when we change how much to jump ahead on the curve each time. we start
     * out incrementing t by 1/30 (the frame rate) but allow the user to 
     * increment t by a greater or lesser amount, thus we have to multiply 
     * by the dtheta (ie, dt) adjustment and divide by the frame rate
     *
     * nb that it is not guaranteed that the lissajous even *has* a frequency
     * (ok, well, technically, yes, it is guaranteed because xFactor and yFactor
     * are both floating-point numbers and therefore xFactor / yFactor is 
     * is rational so at some point the curve must close, but if we do not 
     * truncate them (by multiplying by hzGranularity, eg 10^3 and casting to
     * int) the curve might not close for a lonnnnnng time, and still in the
     * case of truncating to the first three decimal places, will only close 
     * after approx 10^3 seconds.
     */
    g = gcf((int)(hzGranularity*xFactor), (int)(hzGranularity*yFactor));
    mHz = dtheta*frameRate*((float)g)/M_2_PI*pow(10, orderOfMagnitude);
    counter++;
}

- (void) initTimer
{
    julesTimer = [NSTimer
                    scheduledTimerWithTimeInterval:1.f/frameRate
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
    self.hzLabel.text = [NSString stringWithFormat:@"%1.5f Hz", mHz];
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
         animateWithDuration:0.75f animations:^{
             flashView.alpha = 0.0f;
         }
         completion:^(BOOL finished) {
             [flashView removeFromSuperview];
         }
     ];
    
    // play camera sound
    AudioServicesPlaySystemSound(1108);
}

int gcf(int m, int n)
{
    int t, r;
    
    if (m < n)
    {
        t = m;
        m = n;
        n = t;
    }
    
    r = m % n;
    
    if (r == 0)
        return n;
    else
        return gcf(n, r);
}

float roundToN(float num, int p)
{
    if(p == 0)
        return roundf(num);
    
    float f = pow(10, 0-p);
    float n = roundf(f * num)/f;
    if(p > 0)
        n = roundf(n);
    
    return n;
}

// ------------------------------------------------------
// ACTIONS
// ------------------------------------------------------

// action: double tap
// result: show / hide hz label
- (IBAction)tapAction:(UITapGestureRecognizer *)sender
{
    self.hzLabel.hidden = !self.hzLabel.hidden;
}

// action: swipe screen with one finger
// result: update hz (if hzlabel visible)
- (IBAction)panAction:(UIPanGestureRecognizer *)sender
{
    if(!self.hzLabel.hidden)
    {
        float incrementSize = 100000.f;
        CGPoint translation = [sender translationInView:self.view];
        float d = dtheta - (translation.y / incrementSize);
        if(d < 0.001f)
            d = 0.001f;
        if(d > .2f)
            d = .2f;
        dtheta = d;
    }
}

// action: swipe screen with two fingers
// result: reset screen
- (IBAction)doublePanAction:(UIPanGestureRecognizer *)sender
{
     if(sender.state == UIGestureRecognizerStateBegan)
     {
         [self enterBackground];
         [self enterForeground];
    }
}


// action: press and hold
// result: take screenshot
- (IBAction)longPressAction:(UILongPressGestureRecognizer *)sender
{
    if(sender.state == UIGestureRecognizerStateBegan)
        [self takeScreenshot];
}

// action: tap with two fingers
// result: take screenshot
- (IBAction)doubleTapAction:(UITapGestureRecognizer *)sender
{
    [self takeScreenshot];
}


@end
