//
//  ViewController.h
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JulesView.h"

@interface ViewController : UIViewController {
    JulesView *jules;
    NSTimer *julesTimer;
    CADisplayLink *displayLink;
}

-(void) initTimer;
-(void) julesTimerCallBack;

@end
