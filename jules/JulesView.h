//
//  JulesView.h
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

@interface JulesView : UIView
{
    // Instance variables
    float xFactor, yFactor, theta, alpha;
    
    CGSize size;
    
    // CGFloat is typedef for float, could use float instead
    // but this seems better practice for drawing
    CGFloat xPos, yPos, scalar, dotSize;
    
    CGPoint dotPointPrevious;
}

// default functions
- (void)drawRect:(CGRect)rect;
- (id)initWithFrame:(CGRect)frame;

// user-defined functions
- (void)initValues;

@end
