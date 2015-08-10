//
//  DotView.m
//  jules
//
//  Created by lily healey on 05.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import "DotView.h"

@implementation DotView

- (void)drawRect:(CGRect)rect
{
    // Create an oval shape to draw.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    // Set the render colors.
    [[UIColor blueColor] setFill];
    [path fill];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (void) drawDot:(CGRect) rect
{
//    // Create an oval shape to draw.
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
//    
//    // Set the render colors.
//    [[UIColor redColor] setFill];
//    [path fill];
}

@end