//
//  InterfaceController.h
//  watch WatchKit Extension
//
//  Created by david reinfurt on 12/2/21.
//  Copyright © 2021 o-r-g. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <SceneKit/SceneKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController 

@property (strong, nonatomic) IBOutlet WKInterfaceSKScene *mainScene;
@property (strong, nonatomic) IBOutlet WKTapGestureRecognizer *singleTapRecognizer;
- (IBAction)singleTapAction:(id)sender;

@end
