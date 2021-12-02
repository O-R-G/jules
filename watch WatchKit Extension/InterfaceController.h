//
//  InterfaceController.h
//  watch WatchKit Extension
//
//  Created by david reinfurt on 12/2/21.
//  Copyright © 2021 o-r-g. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController {

    // Instance variables

    int counter;
    float xFactor, yFactor, theta, alpha;
    CGFloat xPos, yPos, scaler, dotSize;
    CGSize size;
    CGPoint dotPointPrevious;
    NSMutableArray *points;
}

@property (strong, nonatomic) IBOutlet WKInterfaceSKScene *mainScene;

// Additional (non-static) methods

- (void) initValues;
- (void) initShape;

@end
