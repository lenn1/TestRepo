//
//  BaseLevel.h
//  Snake Escape
//
//  Created by Lennart Hansen on 18.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "AstLayer.h"
#import "SchlangeLayer.h"
#import "BackgroundLayer.h"
#import "AstNormal.h"
#import "VerkohlterAst.h"
#import "PortalEntry.h"
#import "PortalExit.h"
#import "StachelAst.h"
#import "Rutschiger Ast.h"
#import "AstHindernis.h"
#import "AstSchalter.h"
#import "HUDLayer.h"
#import "MathHelper.h"
#import "PauseLayer.h"
#import "PauseLayerDelegate.h"
#import "CCNodeExt.h"
#import "LevelClearLayer.h"
#import "LevelClearLayerDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Vogel.h"
#import "Feuer.h"
#import "Wasserfall.h"
#import "Baumharz.h"
#import "AstKatapult.h"
#import "Spinne.h"
#import "Stein.h"
#import "Affe.h"
#import "AffeDelegate.h"
@class PauseLayer;

@interface BaseLevel : CCScene<AffeDelegate,PauseLayerDelegate,SchlangeLayerDelegate,AstLayerDelegate,CCTargetedTouchDelegate,LevelClearLayerDelegate,VogelDelegate>
{
    CGFloat deviceHeight;
    CGFloat deviceWidth;
    CGFloat levelWidth;
    AstLayer* astLayer;
    SchlangeLayer* schlangeLayer;
    BOOL touchStartedOnSchlange;
    CGFloat lastTouch;
    BOOL alreadyMoved;
    PauseLayer* pauseLayer;
    HUDLayer* hudLayer;
    NSInteger levelTimeout;
    BOOL schlangeTot;
    BackgroundLayer* backgroundLayer;
    int levelPack;
    BOOL paused;
    NSString* LevelName;
    ALuint fireSound;
    NSMutableSet* FrameUpdateAbles;
    
    // <BOX2D>
    b2World* world;
    // </BOX2D>
    
}
-(id)initWithBackGroundImageFile:(NSString*)imageName AndLevelWidth:(CGFloat)Width;
-(void)restartLevel;
-(void)pauseGame;
-(void)resumeGame;
-(void)nextLevel;
+(CCScene*)scene;
-(void)setLevelSelectionPage;
+(NSArray*)getNeededHighScores;
-(void)addToFrameUpdate:(id)CCNode1 , ...;
-(void)setSchlangeInActive;
-(void)setSchlangeActive;
@property NSInteger levelTimeout;
@property(assign,readonly)NSString* LevelName;
@end
