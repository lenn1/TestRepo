//
//  BaseLevel.m
//  Snake Escape
//
//  Created by Lennart Hansen on 18.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#define CCFollowID 5
#import "BaseLevel.h"
#import "SimpleAudioEngine.h"
#define GAMESHOULDPAUSENOTIFICATION @"GAMESHOULDPAUSENOTIFICATION"

@interface BaseLevel()
-(void)LevelSetup;
-(void)FrameUpdate:(ccTime)delta;
@end

@implementation BaseLevel
@synthesize LevelName;
-(id)initWithBackGroundImageFile:(NSString*)imageName AndLevelWidth:(CGFloat)Width;
{  

    if(self=[super init])
    {   
        schlangeTot = NO;
        CGSize size = [[CCDirector sharedDirector] winSize];
        deviceWidth = size.width;
        deviceHeight = size.height;
        
        levelWidth = Width;
        physicsEnabled = YES;
        
        // <Box2D>
        
            
            b2Vec2 gravity = b2Vec2(0.0f, -510.0f/PTM_RATIO);
            world = new b2World(gravity);
            
            
            b2BodyDef groundBodyDef;
            groundBodyDef.position.Set(levelWidth/2.0/PTM_RATIO, (deviceHeight+2)/PTM_RATIO);
            b2Body* groundBody = world->CreateBody(&groundBodyDef);
            b2PolygonShape groundBox;
            b2FixtureDef groundFixture;
            groundFixture.shape = &groundBox;
            groundFixture.friction = 0.01;
            groundFixture.restitution = 0.3;

            groundBox.SetAsBox(levelWidth/2/PTM_RATIO, 1.0f/PTM_RATIO);
            groundBody->CreateFixture(&groundFixture);
            
            groundBodyDef.position.Set(-2/PTM_RATIO,deviceHeight/2/PTM_RATIO);
            groundBody = world->CreateBody(&groundBodyDef);
            groundBox.SetAsBox(1.0/PTM_RATIO, deviceHeight/2/PTM_RATIO);
            groundBody->CreateFixture(&groundFixture);

            groundBodyDef.position.Set((levelWidth+2)/PTM_RATIO,deviceHeight/2/PTM_RATIO);
            groundBody = world->CreateBody(&groundBodyDef);
            groundBox.SetAsBox(1.0/PTM_RATIO, deviceHeight/2/PTM_RATIO);
            groundBody->CreateFixture(&groundFixture);
 
        // </Box2D>
        
        touchStartedOnSchlange = NO;
        backgroundLayer = [[BackgroundLayer alloc]initWithLevelWidth:Width AndHeight:deviceHeight AndImageFile:imageName];

        [self addChild:backgroundLayer];
        astLayer = [[AstLayer alloc]init];
        astLayer.delegate = self;
        [self addChild:astLayer];
        
        schlangeLayer = [[SchlangeLayer alloc]initWithLevelWidth:levelWidth AndWorld:world];
        schlangeLayer.delegate = self;
        [self addChild:schlangeLayer];
        
 
        hudLayer = [[HUDLayer alloc]init];
        [self addChild:hudLayer];

        [self LevelSetup];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pauseGame) name:GAMESHOULDPAUSENOTIFICATION object:nil];
        [self setLevelSelectionPage];

    }
    return self;
}
-(void)LevelSetup;
{
  //OVERRIDE IN LEVELS TO SETUP
}
-(void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
    [self schedule:@selector(FrameUpdate:)];
    
    PortalEntry* portalEntry = [[PortalEntry alloc] init];
    portalEntry.position = schlangeLayer.schlange.position;
    [astLayer addAeste:portalEntry,nil];
    fireSound = [[SimpleAudioEngine sharedEngine]playEffect:@"feuer.mp3"];
    [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"HintergrundVoegel.mp3" loop:YES];
    [[SimpleAudioEngine sharedEngine]setBackgroundMusicVolume:0.05];
    [super onEnter];
}
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
}
-(void)onExit
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    // BOX2D
    delete world;
    
    
    [self unscheduleAllSelectors];
    
    [super onExit];
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine]stopEffect:fireSound];
    [[SimpleAudioEngine sharedEngine]setBackgroundMusicVolume:1];

}

+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:5000];
    NSNumber* twoStars = [NSNumber numberWithInt:10000];
    NSNumber* threeStars = [NSNumber numberWithInt:13000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}

-(void)FrameUpdate:(ccTime)delta
{   

    /* BOX2D KRAM */
    if(world != NULL)
    {
        if(physicsEnabled)
            world->Step(delta, 10, 10);
        for(b2Body *b = world->GetBodyList(); b; b=b->GetNext()) 
        {    

        }
    }
    
    // BOX2D KRAM ENDE
    
    
    
    
        [schlangeLayer FrameUpdate:delta];
        [astLayer FrameUpdate:delta];

    //  HUD an der richtigen Position halten   
    hudLayer.position = ccp(-self.position.x, hudLayer.position.y);
    
    
    // <KAMERA VERFOLGUNG> 
    if(schlangeLayer.schlangeInAir)
    {
        CGFloat SchlangeXPositionOnScreen = schlangeLayer.schlange.position.x+self.position.x;
        
        if((SchlangeXPositionOnScreen > 235 && SchlangeXPositionOnScreen < 245) && !alreadyMoved)
        {
            [self runAction:[CCCallFunc actionWithTarget:self selector:@selector(followSchlange)]];
            alreadyMoved = YES;

        }
        else if(SchlangeXPositionOnScreen < 15 && !alreadyMoved)
        {
            CGFloat duration;
            if(-self.position.x < deviceWidth/2)
                duration = 0.2;
            else
                duration = 0.5;
            
            id moveTo;  
            if(-(schlangeLayer.schlange.position.x-deviceWidth/3*2) < 0)
                moveTo = [CCMoveTo actionWithDuration:duration position:ccp(-(schlangeLayer.schlange.position.x-deviceWidth/3*2),self.position.y)];
            else
                moveTo = [CCMoveTo actionWithDuration:duration position:ccp(0,self.position.y)];
               
            [self runAction:[CCSequence actions:moveTo, nil]];
            alreadyMoved = YES;
        }
        else if(SchlangeXPositionOnScreen > deviceWidth -15 && !alreadyMoved)
        {
            
            CGFloat duration;
            if(-self.position.x > levelWidth-deviceWidth/2)
                duration = 0.2;
            else
                duration = 0.5;

            id moveTo;
            if((schlangeLayer.schlange.position.x+deviceWidth/3*2) > levelWidth-deviceWidth)
                moveTo = [CCMoveTo actionWithDuration:duration position:ccp(-(levelWidth-deviceWidth),self.position.y)];
            else
                moveTo = [CCMoveTo actionWithDuration:duration position:ccp(-(schlangeLayer.schlange.position.x+deviceWidth/3*2),self.position.y)];
            
            [self runAction:[CCSequence actions:moveTo, nil]];
            alreadyMoved = YES;
        }
    }
    // </KAMERA VERFOLGUNG>  
    
    
    
}
-(void)restartLevel
{
    [[CCDirector sharedDirector]replaceScene:[[self class] scene]];

}


+(CCScene*)scene
{
    return nil;
}


-(void)followSchlange
{
    CCAction* follow = [CCFollow actionWithTarget:schlangeLayer.schlange worldBoundary:CGRectMake(0, 0, levelWidth, deviceHeight)];
    follow.tag = CCFollowID;
    [self runAction:follow];
}

-(void)pauseGame
{
    if(!paused)
    {
        LevelName = NSStringFromClass([self class]);
        [self pauseTimersForHierarchy];
        pauseLayer = [PauseLayer alloc];
        pauseLayer.levelName = LevelName;
        [pauseLayer init];
        pauseLayer.position = ccp(-self.position.x,pauseLayer.position.y);
        pauseLayer.delegate = self;
        [self addChild:pauseLayer]; 
        paused = YES;
    }
    
    
}

-(void)resumeGame
{
    [self resumeTimersForHierarchy];
    paused = NO;
}


// LEVELBEWEGUNG
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint locationOnScreen = [touch locationInView: [touch view]];
    locationOnScreen = [[CCDirector sharedDirector] convertToGL: locationOnScreen];
    if(!touchStartedOnSchlange)
    {
        
        lastTouch = locationOnScreen.x;
    }
    else 
    {    
        
        // Falls die Schlange zu dicht am Rand aufgezogen wird, 
        // wird das level um 100 punkte bewegt. (nur links und rechts)
        
        if(locationOnScreen.x < 80)
        {
            CGFloat temp = 100-locationOnScreen.x;
            if(self.position.x + temp <= 0)
            {
                CCFiniteTimeAction* moveAction = [CCMoveBy actionWithDuration:0.2 position:ccp(temp,self.position.y)];
                [self runAction:[CCSequence actions:moveAction, nil]];

            }
            else
            {
                [self runAction:[CCMoveTo actionWithDuration:0.2 position:ccp(0,self.position.y)]];
            }
            
            
            [schlangeLayer setSchlangeLangGezogen:ccp(schlangeLayer.schlange.position.x-temp,locationOnScreen.y)];

        }
        
        if(locationOnScreen.x > deviceWidth-80)
        {
            CGFloat temp = 100-(480-locationOnScreen.x);
            if(self.position.x - temp > -levelWidth+deviceWidth)
                [self runAction:[CCMoveBy actionWithDuration:0.2 position:ccp(-temp,self.position.y)]];
            else
                [self runAction:[CCMoveTo actionWithDuration:0.2 position:ccp(-levelWidth+deviceWidth,self.position.y)]];

            [schlangeLayer setSchlangeLangGezogen:ccp(schlangeLayer.schlange.position.x+temp,locationOnScreen.y)];
            
        }
        
        
    }

    return YES;
}
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!touchStartedOnSchlange)
    {
        CGPoint locationOnScreen = [touch locationInView: [touch view]];
        locationOnScreen = [[CCDirector sharedDirector] convertToGL: locationOnScreen];

        CGFloat temp = locationOnScreen.x - lastTouch;
        if(-(self.position.x + temp) < 0)
            self.position = ccp(0, 0);
        else if(-(self.position.x + temp) >= levelWidth-deviceWidth)
        {
            self.position = ccp(-(levelWidth-deviceWidth),0);
        }
        else
        {
            self.position = ccp(self.position.x + temp,0);
            
        }
        lastTouch = locationOnScreen.x;    
    }
}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    // PAUSE MENÜ 
    CGPoint locationOnScreen = [touch locationInView: [touch view]];
    locationOnScreen = [[CCDirector sharedDirector] convertToGL: locationOnScreen];
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    if(!touchStartedOnSchlange &&  CGRectContainsPoint(CGRectMake(winSize.width-40, winSize.height-40, 40, 40), locationOnScreen))
    {
        [self pauseGame];
    }
    
} 


-(void)setLevelTimeout:(NSInteger)remainingTime
{
    levelTimeout = remainingTime;
    hudLayer.remainingTime = remainingTime;
    [self schedule:@selector(restartLevel) interval:remainingTime];
}
-(NSInteger)levelTimeout
{
    return levelTimeout;
}
-(void)setLevelSelectionPage
{
    [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithInt:levelPack] forKey:@"LevelSelectionPage"];
}

-(void)collisionDetectedWithAst:(AstNormal *)ast
{
    [self stopActionByTag:CCFollowID];
    alreadyMoved = NO; // FÜR KAMERAVERFOLGUNG

    physicsEnabled = NO;
    [schlangeLayer moveSchlangeTo:ast.position];
    
    
    //---------- PORTALEXIT     
    if([ast isKindOfClass:[PortalExit class]])
        [schlangeLayer.schlange runAction:[CCRotateTo actionWithDuration:0.5 angle:10000]];
    else
       // [schlangeLayer runSchlangMovesToAstAnimationWithAst:ast];
        
    //---------- /PORTALEXIT     

        
    //---------- STACHELAST     
        
    if([ast isKindOfClass:[StachelAst class]])
    {
        if([(StachelAst*)ast stachelAusgefahren])
        {
            [[SimpleAudioEngine sharedEngine]playEffect:@"StachelAst.wav"];
            physicsEnabled = YES;
            [schlangeLayer.schlange setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange0"]];
            schlangeLayer.schlangeInAir = YES;
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);


            //BOX2D
            
            schlangeLayer._body->SetLinearVelocity(b2Vec2(0.0/PTM_RATIO, 100.0/PTM_RATIO));
        }
    }
    
    
    //---------- ASTSCHALTER
    if([ast isKindOfClass:[AstSchalter class]])
    {
        if(![(AstSchalter*)ast schalterUnten])
        {
            [self stopAllActions];
            [schlangeLayer moveSchlangeTo:ccp(ast.position.x,ast.position.y+30)];
            [schlangeLayer moveSchlangeTo:ccp(ast.position.x,ast.position.y-30) WithDelay:0.1 AndDuration:0.3];
        }
        else
        {
            [self stopAllActions];
            [schlangeLayer moveSchlangeTo:ccp(ast.position.x,ast.position.y-30)];
        }
        
    }
    //---------- /ASTSCHALTER   
    
    
    
    [ast AstWurdeBesucht];

}
-(void)schlangeTot
{
    if(!schlangeTot)
    {
        schlangeTot = YES;
        [self unschedule:@selector(restartLevel)];
        [self schedule:@selector(restartLevel) interval:1.5];
        [[SimpleAudioEngine sharedEngine]playEffect:@"fallen.wav"];
        [self stopActionByTag:CCFollowID];
    }
}
-(void)PortalErreicht
{
    
    
    CCFiniteTimeAction* scaleAction = [CCScaleTo actionWithDuration:0.5 scale:0.01];
    CCFiniteTimeAction* opacityAction = [CCFadeTo actionWithDuration:0.1 opacity:0];
    CCCallFunc* callLevelCleared = [CCCallFunc actionWithTarget:self selector:@selector(LevelCleared)];
    CCSequence* seq = [CCSequence actions:scaleAction,opacityAction,callLevelCleared, nil];
    
    [schlangeLayer.schlange runAction:seq];
    

    
}

-(void)LevelCleared
{
    LevelName = NSStringFromClass([self class]);
    if([[[NSUserDefaults standardUserDefaults]objectForKey:LevelName]intValue] < (hudLayer.remainingTime*1000))
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:hudLayer.remainingTime*1000] forKey:LevelName];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    [self pauseTimersForHierarchy];
    paused = YES;
    LevelClearLayer* levelClearLayer = [[LevelClearLayer alloc]initWithHighScore:(hudLayer.remainingTime*1000)];
    
    levelClearLayer.position = ccp(-self.position.x,levelClearLayer.position.y);
    levelClearLayer.delegate = self;
    [self addChild:levelClearLayer];
    

}
-(void)nextLevel
{
    // OVERRIDE ! 
}


-(void)VerkohlterAstTimeIsUp:(VerkohlterAst *)ast
{
    if(schlangeLayer.schlange.position.x == ast.position.x && schlangeLayer.schlange.position.y == ast.position.y)
    {
        [[SimpleAudioEngine sharedEngine]stopEffect:schlangeLayer.aufziehsound];
        physicsEnabled = YES;
        schlangeLayer.schlangeInAir = YES;
        [schlangeLayer.schlange setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange0"]];
    }
}

-(BOOL)IsPhysicsEnabled
{
    return physicsEnabled;
}
-(CGPoint)getSchlangePosition
{
    return schlangeLayer.schlange.position;
}
-(void)schlangeAbschiessenCancel
{
    touchStartedOnSchlange = NO;
}
-(void)touchStartedOnSchlange
{
    touchStartedOnSchlange = YES;
}
-(void)touchEndedOnSchlange
{
    touchStartedOnSchlange = NO;
    physicsEnabled = YES;
}



@end
