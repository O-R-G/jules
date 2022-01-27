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

@synthesize singleTapRecognizer;

- (void)awakeWithContext:(id)context {
    // Configure interface objects here.

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
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
}

- (IBAction)singleTapAction:(id)sender {
    NSLog(@"****** TAP ******");

    // better way to get mainScene? instance variable? or ...
    
    FaceScene *mainScene = [FaceScene nodeWithFileNamed:@"FaceScene"];

    [mainScene removeAllChildren];
    
    // this is brute force
    [self.mainScene presentScene: mainScene];
    
    // ** would be better to make these methods public **
    // [mainScene initScene];
    // [mainScene initLissajous];
}

@end



