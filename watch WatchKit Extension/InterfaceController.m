//
//  InterfaceController.m
//  watch WatchKit Extension
//
//  Created by david reinfurt on 12/2/21.
//  Copyright © 2021 o-r-g. All rights reserved.
//

#import "InterfaceController.h"
#import <SpriteKit/SpriteKit.h>
#import "FaceScene.h"

@implementation InterfaceController

@synthesize group;
@synthesize hzSlider;
@synthesize singleTapRecognizer;

- (void)awakeWithContext:(id)context {
    // Configure interface objects here.

    self.crownSequencer.delegate = self;

    /*
        using storyboard with InterfaceController which contains
        mainScene WKINterfaceScene holder object to display FaceScene class
        where all the main logic exists, mostly copied from jules/ViewController
        but instead of Core Animation, using SpriteKit
    */  
    
    FaceScene *mainScene = [FaceScene nodeWithFileNamed:@"FaceScene"];
    [self.mainScene presentScene: mainScene];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [self.crownSequencer focus];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
}

- (IBAction)singleTapAction:(id)sender {
    NSLog(@"****** TAP ******");

    // better way to get mainScene? instance variable? or ...
    
    FaceScene *mainScene = [FaceScene nodeWithFileNamed:@"FaceScene"];

    // dont actually need these as above already calls
    /*
    [mainScene removeAllChildren];
    [mainScene initScene];
    [mainScene initLissajous];
    */
    
    [self.mainScene presentScene: mainScene];
}


- (void) crownDidRotate:(WKCrownSequencer *)crownSequencer rotationalDelta:(double)rotationalDelta {

    /*
        update FaceScene dtheta (used to calculate mHz)
        dtheta is the time delta between drawing dots in range:

            0.001f < dtheta < 0.2f      (default = .03333)
        
        _hz_delta is used to update slider in range:

            0 < _hz_delta < 50
    */

    if (rotationalDelta > 0 && _hz_delta < 50) _hz_delta++;
    if (rotationalDelta < 0 && _hz_delta > 1) _hz_delta--;
        
    // map _hz_delta onto dtheta range based on
    // float out = outMin + (outMax - outMin) * (in - inMin) / (inMax - inMin);
    float dtheta = 0.001f + (0.2f - 0.001f) * (_hz_delta - 0) / (50 - 0);       // local

    [hzSlider setHidden:0];
    [hzSlider setValue:_hz_delta];

    FaceScene *mainScene = [FaceScene nodeWithFileNamed:@"FaceScene"];   
    [mainScene setDtheta: dtheta];
    [self.mainScene presentScene: mainScene];

    NSLog(@"****** ROTATE ******");
    NSLog(@"%1.5f", dtheta);
}

- (void) crownDidBecomeIdle:(WKCrownSequencer *)crownSequencer {
    [NSThread sleepForTimeInterval:0.1f];
    [hzSlider setHidden:1];
}


@end



