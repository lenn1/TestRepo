//
//  SchlangeLayer.h
//  Snake Escape
//
//  Created by Lennart Hansen on 19.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CocoChips.h"
#import "AstNormal.h"
#import "SimpleAudioEngine.h"
@protocol SchlangeLayerDelegate<NSObject>
@optional
-(void)touchStartedOnSchlange;
-(void)touchEndedOnSchlange;
-(void)schlangeAbschiessenCancel;
-(void)schlangeTot;
@required
-(BOOL)IsPhysicsEnabled;

@end


@interface SchlangeLayer : CCLayer<CCTargetedTouchDelegate>
{
    CPSpace* space;
    CPShape* shape;
    CPBody* body;
    CGFloat levelWidth;
    CCSprite* schlange;
    BOOL touchStartedOnSchlange;
    id<SchlangeLayerDelegate> delegate;
    CGFloat abschussradius;
    BOOL schlangeInAir;
    ALuint aufziehsound;

}
-(void)setSchlangePosition:(CGPoint)position;
-(void)FrameUpdate:(ccTime)delta;
-(id)initWithLevelWidth:(CGFloat)Width;
-(void)moveSchlangeTo:(CGPoint)position;
-(void)moveSchlangeTo:(CGPoint)position WithDelay:(CGFloat)delay AndDuration:(CGFloat)duration;
-(void)runSchlangMovesToAstAnimationWithAst:(AstNormal*)ast;
-(void)setSchlangeLangGezogen:(CGPoint)location;
@property(readwrite,assign)CCSprite* schlange;
@property(readwrite,assign)id<SchlangeLayerDelegate> delegate;
@property(readwrite)BOOL schlangeInAir;
@property(assign)CPBody* body;
@property(assign)CPShape* shape;
@property (readonly)ALuint aufziehsound;
@end
