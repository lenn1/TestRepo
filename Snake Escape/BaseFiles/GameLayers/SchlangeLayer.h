//
//  SchlangeLayer.h
//  Snake Escape
//
//  Created by Lennart Hansen on 19.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AstNormal.h"
#import "SimpleAudioEngine.h"
#import "Box2D.h"
#define PTM_RATIO 32

@protocol SchlangeLayerDelegate<NSObject>
@required
-(void)touchStartedOnSchlange;
-(void)touchEndedOnSchlange;
-(void)schlangeAbschiessenCancel;
-(void)schlangeTot;
-(BOOL)getTouchStartedOnSchlange;
@end


@interface SchlangeLayer : CCLayer<CCTargetedTouchDelegate>
{

    CGFloat levelWidth;
    CCSprite* schlange;
    id<SchlangeLayerDelegate> delegate;
    CGFloat abschussradius;
    BOOL schlangeInAir;
    ALuint aufziehsound;
    BOOL schlangetot;
    unsigned schlangeState;
    b2World* world;
    b2Body* _body;
}
-(void)setSchlangePosition:(CGPoint)position;
-(void)FrameUpdate:(ccTime)delta;
-(id)initWithLevelWidth:(CGFloat)Width AndWorld:(b2World*)worldptr;
-(void)moveSchlangeTo:(CGPoint)position;
-(void)moveSchlangeTo:(CGPoint)position WithDelay:(CGFloat)delay AndDuration:(CGFloat)duration;
-(void)runSchlangMovesToAstAnimationWithAst:(AstNormal*)ast;
-(void)setSchlangeLangGezogen:(CGPoint)location;
-(void)schlangeVerkohlt;
-(void)setSchlangeStateWater;
-(void)setSchlangeStateNormal;
-(void)setSchlangeStateHarz;
-(void)turnSnakePhysicsOn;
@property(readwrite,assign)CCSprite* schlange;
@property(readwrite,assign)id<SchlangeLayerDelegate> delegate;
@property(readwrite)BOOL schlangeInAir;
@property(assign)b2Body* _body;
@property (readonly)ALuint aufziehsound;
@property (readonly) unsigned schlangeState;
@end
