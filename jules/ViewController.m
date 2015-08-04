//
//  ViewController.m
//  jules
//
//  Created by lily healey on 04.08.2015.
//  Copyright (c) 2015 o-r-g. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // [self.view setBackgroundColor:[UIColor whiteColor]];
    
    float w = self.view.frame.size.width;
    float h = self.view.frame.size.height;
    
    CGRect displayArea = CGRectMake(0,0, w, h);
    
    jules = [[JulesView alloc] initWithFrame:displayArea];
    [self.view addSubview: jules];
    [self initTimer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void) initTimer
{
    julesTimer = [NSTimer scheduledTimerWithTimeInterval:1.f/30.f
                                         target:self
                                       selector:@selector(julesTimerCallBack)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:julesTimer forMode:NSDefaultRunLoopMode];
}

-(void) julesTimerCallBack
{
    [jules setNeedsDisplay];
}

@end
