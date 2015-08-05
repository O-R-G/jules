//
//  DotView.m
//  jules
//
//  Created by lily healey on 05.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DotView.h"

@implementation DotView

- (void)drawRect:(CGRect)rect
{
    [self drawDot];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
//    if(self)
//        [self initValues];
    return self;
}

- (void) drawDot
{
    // Create an oval shape to draw.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    // Set the render colors.
    [[UIColor redColor] setFill];
    [path fill];
}

@end