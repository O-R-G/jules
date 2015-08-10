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
    if(dotPointPrevious.x != 0)
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
    
    return;
}

// Initialize all values, make new lissajous
- (void) initValues
{
    srand48(time(0));
    
    // float
    theta = 0.0;
    alpha = .9;
    xFactor = (float)drand48() * 2.f;
    yFactor = (float)drand48() * 2.f;
    
    // CGSize
    size = [self bounds].size;
    
    // CGFloat
    xPos = 0;
    yPos = 0;
    scalar = size.width / 2.2;
    dotSize = size.width / 100;

    return;
}

@end
