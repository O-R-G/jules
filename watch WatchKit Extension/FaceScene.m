//
//  FaceScene.m
//
//  derived from https://github.com/steventroughtonsmith/SpriteKitWatchFace
//


#import "FaceScene.h"
#import <WatchKit/WatchKit.h>

@implementation FaceScene

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

// CG*
@synthesize size;
@synthesize scalar;
@synthesize dotPoint;
@synthesize dp2;
@synthesize dotRect;
@synthesize julesArea;





// init

- (instancetype)initWithCoder:(NSCoder *)coder {
    
	self = [super initWithCoder:coder];
	if (self) {
		self.delegate = self;
	}
    [self initScene];
    [self initLissajous];
	return self;
}

- (void)initScene {

    CGFloat dotSize;
    julesArea = [WKInterfaceDevice currentDevice].screenBounds;
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

    // play haptic 'bing'
    [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeNotification];
}

- (void)initLissajous {

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
    dotPoint.x = scalar * sin(xFactor*theta);   // does not include + size.width / 2;
    dotPoint.y = scalar * sin(yFactor*theta);   // and + size.height / 2;

    counter = 0;
}








// update

- (void)update:(NSTimeInterval)currentTime forScene:(SKScene *)scene {

    if (counter % 1 == 0) {
        [self drawFrame];
    }

    if (counter >= 5000) {

        // remove the scene or anyway clear it
        // with rect or whatever

        [self initScene];
        [self initLissajous];
    }
    counter++;
}

- (void) drawFrame {

    int g;

    [self addChild: [self dotNode]];

    // update values for next frame
    theta += dtheta;
    dotPoint.x = scalar * sin(xFactor*theta);   // does not include + size.width / 2;
    dotPoint.y = scalar * sin(yFactor*theta);   // and + size.height / 2;

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

/* 
    kept for date-time reference as may want to adjust timing using absolute time
*/

- (void)updateHands {
    
	NSDate *now = [NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond| NSCalendarUnitNanosecond) fromDate:now];

    /*
	SKNode *dot = [self childNodeWithName:@"dottie"];
    CGFloat seconds = (2*M_PI)/60 * (CGFloat)(components.second + 1.0/NSEC_PER_SEC*components.nanosecond) * 10;
    dot.position = CGPointMake(seconds,0);  
    */
}





// nodes

- (SKSpriteNode *)dotNode {

    // might be best to make array of dots at start and when exhausted, redraw
    // better to use scaleToSize function?                                         
    // as relative to parent or better yet, SKNode - setScale

    /* remove */
    // shapeLayers = [[NSMutableArray alloc] init];

    SKSpriteNode *dotNode = [SKSpriteNode spriteNodeWithImageNamed:@"dot-100.png"];
    dotNode.size = dotRect.size;
    dotNode.position = dotPoint;

    return dotNode;
}

- (SKLabelNode *)textNode {
    SKLabelNode *textNode = [SKLabelNode labelNodeWithFontNamed: @"Chalkduster"];
    textNode.text = @"hello, world";
    textNode.fontSize = 18;
    textNode.position = CGPointMake(500,10);
    return textNode;
}





// utility maths

int gcf(int m, int n) {

    int t, r;

    if (m < n) {
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

float roundToN(float num, int p) {

    if(p == 0)
        return roundf(num);

    float f = pow(10, 0-p);
    float n = roundf(f * num)/f;
    if(p > 0)
        n = roundf(n);

    return n;
}


@end
