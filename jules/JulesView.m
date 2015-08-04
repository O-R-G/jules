//
//  JulesView.m
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JulesView.h"

@implementation JulesView

- (void)drawRect:(CGRect)rect
{
    [self drawFrame];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void) drawFrame
{
    [self initValues];
    
    UIBezierPath *path;
    CGRect dotRect, dotRectStub, screenRect;
    CGPoint dotPoint, dotPointStub;
    
    dotRect.size = CGSizeMake(dotSize, dotSize);
    dotRectStub.size = CGSizeMake(dotSize, dotSize);
    
    // calculate wave, set origin
    theta += 0.035;
    xPos = scaler * (sin(xFactor*theta)) + size.width / 2;
    yPos = scaler * (sin(yFactor*theta)) + size.height / 2;
    dotPoint.x = xPos;
    dotPoint.y = yPos;
    dotRect.origin = dotPoint;
    
    path = [UIBezierPath bezierPathWithOvalInRect:dotRect];
    [[UIColor redColor] setFill];
    [path fill];
    
    // draw previous point
    if(counter > 0)
    {
        dotPointStub.x = dotPointPrevious.x;
        dotPointStub.y = dotPointPrevious.y;
        dotRectStub.origin = dotPointPrevious;
        
        path = [UIBezierPath bezierPathWithOvalInRect:dotRectStub];
        [[UIColor redColor] setFill];
        [path fill];
    }
    
    // store this point for next loop
    dotPointPrevious = dotPoint;
    
    
//    // Check number of loops and redraw shape periodically
//    if(counter > 3600)
//    {
//        [self initShape];
//        
//        // clear screen
//        screenRect.size = CGSizeMake(size.width, size.height);
//    }
//    else
//        counter++;
    
    return;
}

// Initialize all values, make new lissajous
- (void) initValues
{
    xPos = 0;
    yPos = 0;
    size = [self bounds].size;
    scaler = size.height / 2.2;
    theta = 0.0;
    dotSize = size.width / 20;
    alpha = .9;
    
    [self initShape];
    
    return;
}

- (void) initShape
{
    // Initialize a and b
    xFactor = ((float)rand() / RAND_MAX) * 2;
    yFactor = ((float)rand() / RAND_MAX) * 2;
    counter = 0;
    return;
}



@end
