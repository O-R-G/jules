//
//  InterfaceController.h
//  watch WatchKit Extension
//
//  Created by david reinfurt on 12/2/21.
//  Copyright © 2021 o-r-g. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface InterfaceController : WKInterfaceController <WKCrownDelegate> {
    BOOL paused;
}

@property (strong, nonatomic) IBOutlet WKInterfaceGroup *group;
@property (strong, nonatomic) IBOutlet WKInterfaceSKScene *mainScene;
@property (strong, nonatomic) IBOutlet WKTapGestureRecognizer *singleTapRecognizer;
@property (strong, nonatomic) IBOutlet WKInterfaceSlider *hzSlider;
@property (nonatomic) int hz_delta;
// Add audio player property
@property (nonatomic, strong) AVAudioPlayer *backgroundMusic;

- (IBAction)singleTapAction:(id)sender;

@end
