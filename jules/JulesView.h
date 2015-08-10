//
//  JulesView.h
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JulesView : UIView
{
    // Instance variables
    float xFactor, yFactor, theta;
    
    CGSize size;
    
    // CGFloat is typedef for float, could use float instead
    // but this seems better practice for drawing
    CGFloat scalar;
    
    CGPoint dotPoint, dotPointPrevious, dotPointPP;
    
    CGRect dotRect;
}

- (float) xFactor;
- (float) yFactor;
- (CGPoint) dotPoint;

// default functions
- (void)drawRect:(CGRect)rect;
- (id)initWithFrame:(CGRect)frame;

// user-defined functions
- (void)initValues;

@end
