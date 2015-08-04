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
    if(self)
        [self initValues];
    return self;
}

- (void) drawFrame
{
    UIBezierPath *path;
    CGRect dotRect, dotRectStub;
    CGPoint dotPoint, dotPointStub;
    
    dotRect.size = CGSizeMake(dotSize, dotSize);
    dotRectStub.size = CGSizeMake(dotSize, dotSize);
    
    // calculate wave, set origin
    theta += 0.035;
    xPos = scalar * (sin(xFactor*theta)) + size.width / 2;
    yPos = scalar * (sin(yFactor*theta)) + size.height / 2;
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
    
    
    // Check number of loops and redraw shape periodically
    if(counter > 3600)
    {
        [self initShape];
        // clear screen
        [self setBackgroundColor:[UIColor blackColor]];
        NSLog(@"reset!");
    }
    else
        counter++;
    
    return;
}

// Initialize all values, make new lissajous
- (void) initValues
{
    xPos = 0;
    yPos = 0;
    size = [self bounds].size;
    scalar = size.width / 2.2;
    theta = 0.0;
    dotSize = size.width / 100;
    alpha = .9;
    
    [self initShape];
    
    return;
}

- (void) initShape
{
    // Initialize a and b
    srand48(time(0));
    xFactor = (float)drand48() * 2.f;
    yFactor = (float)drand48() * 2.f;
    counter = 0;
    return;
}

@end
