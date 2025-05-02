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
    // Set up and start background music
    [self setupBackgroundMusic];
    /*
        using storyboard with InterfaceController which contains
        mainScene WKINterfaceScene holder object to display FaceScene class
        where all the main logic exists, mostly copied from jules/ViewController
        but instead of Core Animation, using SpriteKit
    */  
    
    FaceScene *mainScene = [FaceScene nodeWithFileNamed:@"FaceScene"];
    [self.mainScene presentScene: mainScene];
}
// Add this new method to setup background music
- (void)setupBackgroundMusic {
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *audioURL = [bundle URLForResource:@"jingle" withExtension:@"mp3"];
    if (audioURL) {
        NSError *error = nil;
        
        // Initialize audio session for background playback
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
        if (error) {
            NSLog(@"Error setting audio session category: %@", error.localizedDescription);
        }
        
        // Create audio player
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&error];
        if (error) {
            NSLog(@"Error creating audio player: %@", error.localizedDescription);
            return;
        }
        
        self.backgroundMusic.delegate = (id)self;
        self.backgroundMusic.numberOfLoops = -1; // Infinite looping
        [self.backgroundMusic prepareToPlay];
        [self.backgroundMusic play];
    } else {
        NSLog(@"Background music file not found");
    }
}
- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    // Resume background music when app becomes active
    if (self.backgroundMusic && !paused) {
        [self.backgroundMusic play];
    }
    _hz_delta = 25;
    [hzSlider setValue:_hz_delta];
    [self.crownSequencer focus];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    if (self.backgroundMusic) {
        [self.backgroundMusic pause];
    }
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

            0.001f < dtheta < 0.066f      (default = 0.033f)
        
        _hz_delta is used to update slider in range:

            0 < _hz_delta < 50
    */

    if (rotationalDelta > 0 && _hz_delta < 50) _hz_delta++;
    if (rotationalDelta < 0 && _hz_delta > 1) _hz_delta--;
        
    float dtheta = 0.001f + (0.066f - 0.001f) * (_hz_delta - 0) / (50 - 0);       

    [hzSlider setHidden:0];
    [hzSlider setValue:_hz_delta];

    FaceScene *mainScene = [FaceScene nodeWithFileNamed:@"FaceScene"];   
    [mainScene setDtheta: dtheta];
    [self.mainScene presentScene: mainScene];

    // NSLog(@"****** ROTATE ******");
    NSLog(@"%1.5f ROTATE: DTHETA", dtheta);
    NSLog(@"%1.5f ROTATE: ROTATIONAL DELTA", rotationalDelta);
}

- (void) crownDidBecomeIdle:(WKCrownSequencer *)crownSequencer {
    [NSThread sleepForTimeInterval:0.1f];
    [hzSlider setHidden:1];
}


@end



