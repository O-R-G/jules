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

    NSLog(@"****** ROTATE ******");

    // surely an easier way to do this with %

    // if (rotationalDelta > 0 && _hz_delta < 50) _hz_delta++;
    // if (rotationalDelta < 0 && _hz_delta > 1) _hz_delta--;

    // hz = _hz_delta; // adjust to map onto hz range, refer to ios app

    // ** for debug **
    // NSString *name = [NSString stringWithFormat:@"%d", _hz_delta];
    // self.mouthLabel.text = name;
    

    // make hzSlider visible, update value
    [hzSlider setHidden:0];
    // [hzSlider setValue:hz];
    // [group setBackgroundColor:[UIColor darkGrayColor]];
    
    /*
    if(paused)
        [self killTimer];
    else {
        [self killTimer];
        [self initTimer];
    }
     */
}

- (void) crownDidBecomeIdle:(WKCrownSequencer *)crownSequencer {
    // nothing for now
    [NSThread sleepForTimeInterval:0.1f];
    [hzSlider setHidden:1];
    // [group setBackgroundColor:[UIColor whiteColor]];
}


@end



