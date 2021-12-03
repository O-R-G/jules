//
//  InterfaceController.m
//  watch WatchKit Extension
//
//  Created by david reinfurt on 12/2/21.
//  Copyright © 2021 o-r-g. All rights reserved.
//

#import "InterfaceController.h"
// #import "HelloScene.h"
#import <SpriteKit/SpriteKit.h>

@interface InterfaceController ()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    // Configure interface objects here.
    
    // make a scene object
    // present it in the mainScene "holder" which itself is inside a spriteKit scene viewer of type WKInterfaceSKScene
    // will basically transppose logic from JulesView (ios) and
    // add that to this spriteKit scene
    // i need better names for these nester views, scenes 
    SKScene *main = [[SKScene alloc] initWithSize:CGSizeMake(100, 100)];
    main.backgroundColor = [SKColor blueColor];
    [main addChild: [self newHelloNode]];
    [self.mainScene presentScene: main];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    // HelloScene *hello = [[HelloScene alloc] initWithSize:CGSizeMake(200, 200)];

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
}

- (SKLabelNode *)newHelloNode {
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed: @"Chalkduster"];
    helloNode.text = @"hello, world";
    helloNode.fontSize = 18;
    helloNode.position = CGPointMake(10,10);
    return helloNode;
}

@end



