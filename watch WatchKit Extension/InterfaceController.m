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

- (void)awakeWithContext:(id)context {
    // Configure interface objects here.
    
    // make a scene object
    // present it in the mainScene "holder" which itself is inside a spriteKit scene viewer of type WKInterfaceSKScene
    // will basically transppose logic from JulesView (ios) and
    // add that to this spriteKit scene
    // i need better names for these nester views, scenes
    // init scene object (also could assign the spritekit scene in storyboard to a class)
    // size is arbitrary in points, then adjusted to display resolution
    
    // CGSize currentDeviceSize = [WKInterfaceDevice currentDevice].screenBounds.size;

    // programmatically add scene
    /*
    SKScene *main = [[SKScene alloc] initWithSize:CGSizeMake(1000, 1000)];
    main.backgroundColor = [SKColor blackColor];
    main.scaleMode = SKSceneScaleModeAspectFit;
    
    // populate scene
    // [main addChild: [self textNode]];
    [main addChild: [self dotNode]];
     // [scene addChild: [self dotNode]];
    */
    
    FaceScene *mainScene = [FaceScene nodeWithFileNamed:@"FaceScene"];
    
    // mainScene.backgroundColor = [SKColor blueColor];

    // [mainScene addChild: [self dotNode]];

    // present scene
    // [self.mainScene presentScene: main];
    [self.mainScene presentScene: mainScene];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
}

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
    return dotNode;
}

@end



