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
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    float w = self.view.frame.size.width;
    float h = self.view.frame.size.height;
    
    //CGRect displayArea = CGRectMake(0,0, w, h);
    CGRect displayArea = CGRectMake(w/2,h/2, w/100, w/100);
    dotView = [[DotView alloc] initWithFrame:displayArea];
    [self.view addSubview: dotView];
    [self animateDot];
    
    // julesView = [[JulesView alloc] initWithFrame:displayArea];
    // [self.view addSubview: julesView];
    
    // [self initTimer];
    
    CGPoint myNewPosition;
    myNewPosition.x = 0.0;
    myNewPosition.y = 0.0;
    [UIView animateWithDuration:1.0 animations:^{
        // Change the opacity implicitly.
        // julesView.layer.opacity = 0.0;
        
        // Change the position explicitly.
        CABasicAnimation* theAnim = [CABasicAnimation animationWithKeyPath:@"position"];
        theAnim.fromValue = [NSValue valueWithCGPoint:dotView.layer.position];
        theAnim.toValue = [NSValue valueWithCGPoint:myNewPosition];
        theAnim.duration = 3.0;
        [dotView.layer addAnimation:theAnim forKey:@"AnimateFrame"];
    }];
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
    [julesView setNeedsDisplay];
}

- (void) animateDot
{
//    CGMutablePathRef
//    CGPoint pos;
//    int cycles = 3600;
//    float delta = 0.035;
//    float theta = 0.0;
//    float scalar = self.view.frame.size.width / 2.2;
//    srand48(time(0));
//    float xFactor = (float)drand48() * 2.f;
//    float yFactor = (float)drand48() * 2.f;
//    CGSize size = self.view.frame.size;
//    
//    pos.x = 0.0;
//    pos.y = 0.0;
    
//    for(int i = 0; i < cycles; i++)
//    {
//        theta += delta;
//        pos.x = scalar * sin(xFactor*theta) + size.width / 2;
//        pos.y = scalar * sin(yFactor*theta) + size.height / 2;
//    }
//    
//    [UIView animateWithDuration:1.0 animations:^{
//        CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"position"];
//        anim.fromValue = [NSValue valueWithCGPoint:dotView.layer.position];
//        anim.toValue = [NSValue valueWithCGPoint:pos];
//        anim.duration = 1.0/30.0;
//        [dotView.layer addAnimation:anim forKey:@"AnimateFrame"];
//        
//    }];
}

@end
