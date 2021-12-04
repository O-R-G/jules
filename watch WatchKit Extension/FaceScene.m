//
//  FaceScene.m
//
//  derived from https://github.com/steventroughtonsmith/SpriteKitWatchFace
//

/*
    add initLissajousInit, CGPoint (?) calculateLissajous (to get next point to draw)
    look into counter logic and how often updates, spriteKit framerate
    can that be displayed

    for lissajous logic, see jules/ViewController

    eventually add digital crown to adjust Hz
*/




#import "FaceScene.h"


@implementation FaceScene

// instance variables

@synthesize counter;




// init

- (instancetype)initWithCoder:(NSCoder *)coder {
    
	self = [super initWithCoder:coder];
	if (self) {
		self.delegate = self;
	}
    [self setupScene];
	return self;
}

- (void)setupScene {

    [self addChild: [self dotNode]];
    counter = 0;
}





// update

- (void)update:(NSTimeInterval)currentTime forScene:(SKScene *)scene {
    
	[self updateHands];
    if (counter % 7 == 0) {
        [self addChild: [self dotNode]];
    }
    counter++;
}

- (void)updateHands {
    
	NSDate *now = [NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond| NSCalendarUnitNanosecond) fromDate:now];

	SKNode *dot = [self childNodeWithName:@"dottie"];
    CGFloat seconds = (2*M_PI)/60 * (CGFloat)(components.second + 1.0/NSEC_PER_SEC*components.nanosecond) * 10;
    dot.position = CGPointMake(seconds,0);  
}






// nodes

- (SKLabelNode *)textNode {
    SKLabelNode *textNode = [SKLabelNode labelNodeWithFontNamed: @"Chalkduster"];
    textNode.text = @"hello, world";
    textNode.fontSize = 18;
    textNode.position = CGPointMake(500,10);
    return textNode;
}

- (SKSpriteNode *)dotNode {
    SKSpriteNode *dotNode = [SKSpriteNode spriteNodeWithImageNamed:@"dot-100.png"];
    dotNode.position = CGPointMake(counter/1.5,counter*0.5);
    dotNode.size = CGSizeMake(10,10);   // better to use scaleToSize function? as relative to parent 
                                        // or better yet, SKNode - setScale
    dotNode.name = @"dottie";

    return dotNode;
}




@end
