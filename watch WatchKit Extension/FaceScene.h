//
//  FaceScene.h
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceScene : SKScene <SKSceneDelegate>

@property (readonly) int counter;
@property (readonly) int orderOfMagnitude;

@property (readonly) float xFactor;
@property (readonly) float yFactor;
@property (readonly) float theta;
@property (readonly) float dtheta;
@property (readonly) float mHz;
@property (readonly) float hzGranularity;
@property (readonly) float frameRate;

@property (readonly) CGSize size;
@property (readonly) CGFloat scalar;
@property (readonly) CGPoint dotPoint;
@property (readonly) CGPoint dp2;
@property (readonly) CGRect dotRect;
@property (readonly) CGRect julesArea;

@end

NS_ASSUME_NONNULL_END