//
//  FaceScene.m
//

#import "FaceScene.h"

@implementation FaceScene

- (instancetype)initWithCoder:(NSCoder *)coder {
    
	self = [super initWithCoder:coder];
	if (self) {
		self.delegate = self;
	}
	return self;
}




-(void)setupScene {

    // add dot here 

}







- (void)update:(NSTimeInterval)currentTime forScene:(SKScene *)scene {
    
	[self updateHands];
}






- (void)updateHands {
    
    // update lissajous here

	NSDate *now = [NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond| NSCalendarUnitNanosecond) fromDate:now];
	
	SKNode *face = [self childNodeWithName:@"Face"];	
	SKNode *hourHand = [face childNodeWithName:@"Hours"];
	SKNode *minuteHand = [face childNodeWithName:@"Minutes"];
	SKNode *secondHand = [face childNodeWithName:@"Seconds"];

	hourHand.zRotation =  - (2*M_PI)/12.0 * (CGFloat)(components.hour%12 + 1.0/60.0*components.minute);
	minuteHand.zRotation =  - (2*M_PI)/60.0 * (CGFloat)(components.minute + 1.0/60.0*components.second);
	secondHand.zRotation = - (2*M_PI)/60 * (CGFloat)(components.second + 1.0/NSEC_PER_SEC*components.nanosecond);
}




@end
