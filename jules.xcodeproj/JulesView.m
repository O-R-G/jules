//
//  JulesView.m
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import "JulesView.h"

@implementation JulesView

@synthesize dotPoint;


// inherited functions
- (void)drawRect:(CGRect)rect
{
    [self drawFrame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
        [self initValues];
    return self;
}

// user-defined functions
- (void) drawFrame
{
    UIBezierPath *path;
    
    // draw current point
    dotRect.origin = dotPoint;
    path = [UIBezierPath bezierPathWithOvalInRect:dotRect];
    [[UIColor redColor] setFill];
    [path fill];
    
    // draw previous point
    dotRect.origin = dotPointPrevious;
    path = [UIBezierPath bezierPathWithOvalInRect:dotRect];
    [[UIColor redColor] setFill];
    [path fill];

    // draw previous point
    dotRect.origin = dotPointPP;
    path = [UIBezierPath bezierPathWithOvalInRect:dotRect];
    [[UIColor redColor] setFill];
    [path fill];
    
    // store this point for next loop
    dotPointPP = dotPointPrevious;
    dotPointPrevious = dotPoint;
    
    // calculate next point
    theta += 0.035;
    dotPoint.x = scalar * (sin(xFactor*theta)) + size.width / 2;
    dotPoint.y = scalar * (sin(yFactor*theta)) + size.height / 2;
    
    return;
}

// Initialize all values, make new lissajous
- (void) initValues
{
    CGFloat dotSize;
    srand48(time(0));
    
    // float
    theta = 0.035;
    xFactor = (float)drand48() * 2.f;
    yFactor = (float)drand48() * 2.f;
    
    // CGSize
    size = [self bounds].size;
    
    // CGFloat
    scalar = size.width / 2.2;
    dotSize = size.width / 100;
    
    // CGRect
    dotRect.size = CGSizeMake(dotSize, dotSize);
    
    // CGPoint
    dotPoint.x = scalar * (sin(xFactor*theta) + size.width / 2);
    dotPoint.y = scalar * (sin(yFactor*theta) + size.height / 2);
    dotPointPrevious = dotPoint;
    dotPointPP = dotPointPrevious;

    return;
}

@end
