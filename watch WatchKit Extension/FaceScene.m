//
//  FaceScene.m
//

#import "FaceScene.h"


@implementation FaceScene


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
}





// update

- (void)update:(NSTimeInterval)currentTime forScene:(SKScene *)scene {
    
	[self updateHands];
}

- (void)updateHands {
    
	NSDate *now = [NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond| NSCalendarUnitNanosecond) fromDate:now];
	
	SKNode *face = [self childNodeWithName:@"Face"];	
	// SKNode *hourHand = [face childNodeWithName:@"Hours"];
	// SKNode *minuteHand = [face childNodeWithName:@"Minutes"];
	// SKNode *secondHand = [face childNodeWithName:@"Seconds"];
    face.hidden = TRUE;         // clearly a better way to do this (!)
                                // like in the .scs

    // update this with counter
    // may need an array[] of dots as in pickup sticks

	SKNode *dot = [self childNodeWithName:@"dottie"];
    CGFloat seconds = (2*M_PI)/60 * (CGFloat)(components.second + 1.0/NSEC_PER_SEC*components.nanosecond) * 10;
    dot.position = CGPointMake(seconds,0);  

	// hourHand.zRotation =  - (2*M_PI)/12.0 * (CGFloat)(components.hour%12 + 1.0/60.0*components.minute);
	// minuteHand.zRotation =  - (2*M_PI)/60.0 * (CGFloat)(components.minute + 1.0/60.0*components.second);
	// secondHand.zRotation = - (2*M_PI)/60 * (CGFloat)(components.second + 1.0/NSEC_PER_SEC*components.nanosecond);
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
    dotNode.position = CGPointMake(0,0);
    dotNode.size = CGSizeMake(10,10);   // better to use scaleToSize function? as relative to parent 
                                        // or better yet, SKNode - setScale
    dotNode.name = @"dottie";

    return dotNode;
}




@end
