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
#define SchlangeStateNormal 0
#define SchlangeStateWater 1
#define SchlangeStateHarz 2

@interface BaseLevel()
-(void)LevelSetup;
-(void)FrameUpdate:(ccTime)delta;
@end

@implementation BaseLevel

class ContactListener : public b2ContactListener
{
public:
    
    BaseLevel* levelPtr;
    void BeginContact(b2Contact* contact)
    {
        for (b2Contact* c = contact; c; c = c->GetNext())
        {
            id fixA = (id)c->GetFixtureA()->GetUserData();
            id fixB = (id)c->GetFixtureB()->GetUserData();
            
         //   NSLog(@"%@,%@",NSStringFromClass([fixA class]),NSStringFromClass([fixB class]));
            
            // Schlange im Feuer Check.
                if(([fixA isKindOfClass:[Feuer class]] && [fixB isKindOfClass:[SchlangeLayer class]]) || 
                   ([fixB isKindOfClass:[Feuer class]] && [fixA isKindOfClass:[SchlangeLayer class]]))
                {
                    NSLog(@"Feuer an Schlange");
                    if([[levelPtr getSchlangeLayer]schlangeState] != SchlangeStateWater)
                    {
                    [[levelPtr getSchlangeLayer]schlangeVerkohlt];
                    [levelPtr schedule:@selector(schlangeTot) interval:2.0];
                    }
                    else 
                    {
                        [[levelPtr getSchlangeLayer]setSchlangeStateNormal];
                    }
                }
       
            
            // Schlange im Wasser Check.
            if(([fixA isKindOfClass:[Wasserfall class]] && [fixB isKindOfClass:[SchlangeLayer class]]) || 
               ([fixB isKindOfClass:[Wasserfall class]] && [fixA isKindOfClass:[SchlangeLayer class]]))
            {
                NSLog(@"Wasser an Schlange");
                [[levelPtr getSchlangeLayer]setSchlangeStateWater];
            }
            
            // Schlange Baumharz Check.
            if(([fixA isKindOfClass:[Baumharz class]] && [fixB isKindOfClass:[SchlangeLayer class]]) || 
               ([fixB isKindOfClass:[Baumharz class]] && [fixA isKindOfClass:[SchlangeLayer class]]))
            {
                NSLog(@"Baumharz gefangen");
                [[levelPtr getSchlangeLayer]setSchlangeStateHarz];
                if([fixA isKindOfClass:[Baumharz class]])
                    [fixA toDestroy];
                if([fixB isKindOfClass:[Baumharz class]])
                    [fixB toDestroy];
            }
            
            // Schlange im Spinnenfaden Check.
            if(([fixA isKindOfClass:[Spinne class]] && [fixB isKindOfClass:[SchlangeLayer class]]) || 
               ([fixB isKindOfClass:[Spinne class]] && [fixA isKindOfClass:[SchlangeLayer class]]))
            {
                if([fixA isKindOfClass:[Spinne class]])
                    [(Spinne*)fixA fadenGetroffen];
                if([fixB isKindOfClass:[Spinne class]])
                    [(Spinne*)fixB fadenGetroffen];
                
            }
            // Affe hat Ast getroffen Check.
            if(([fixA isKindOfClass:[Affe class]] && [fixB isKindOfClass:[AstNormal class]]) || 
               ([fixB isKindOfClass:[Affe class]] && [fixA isKindOfClass:[AstNormal class]]))
            {
                if([fixA isKindOfClass:[Affe class]])
                    ((Affe*)fixA).astHit = YES;
                if([fixB isKindOfClass:[Affe class]])
                    ((Affe*)fixA).astHit = YES;                
            }
                            
        }
        

        
    }
    
    
    
    void EndContact(b2Contact* contact)
    
    { /* handle end event */ }
    
    
    
    void PreSolve(b2Contact* contact, const b2Manifold* oldManifold)
    
    { /* handle pre-solve event */ }
    
    
    
    void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse)
    
    { /* handle post-solve event */ }
    
};



@synthesize LevelName;
-(id)initWithBackGroundImageFile:(NSString*)imageName AndLevelWidth:(CGFloat)Width;
{  
    
    if(self=[super init])
    {   
        FrameUpdateAbles = [[NSMutableSet alloc]init];
        schlangeTot = NO;
        CGSize size = [[CCDirector sharedDirector] winSize];
        deviceWidth = size.width;
        deviceHeight = size.height;
        
        levelWidth = Width;
        
        // <Box2D>
        
            ContactListener* contactListener = new ContactListener();
            contactListener->levelPtr = self;
            b2Vec2 gravity = b2Vec2(0.0f, -510.0f/PTM_RATIO);
            world = new b2World(gravity);
            world->SetAllowSleeping(true);
            world->SetContactListener(contactListener);
            
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
        astLayer.world = world;
        [self addChild:astLayer];
        
        schlangeLayer = [[SchlangeLayer alloc]initWithLevelWidth:levelWidth AndWorld:world];
        schlangeLayer.delegate = self;
        [self addChild:schlangeLayer];
        
        [self addToFrameUpdate:astLayer,schlangeLayer,nil];
 
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
-(void)addToFrameUpdate:(id)CCNode1 , ...
{
    {
        va_list args;
        va_start(args, CCNode1);
        id node;
        for (node = CCNode1; node != nil;node = va_arg(args, id))
        {
            [FrameUpdateAbles addObject:node];
        }
        va_end(args);
    }

}
-(void)FrameUpdate:(ccTime)delta
{   

        world->Step(delta, 10, 10);
    //Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) 
        {
            if(![(id)(b->GetUserData()) isKindOfClass:[Feuer class]] &&
               ![(id)(b->GetUserData()) isKindOfClass:[Wasserfall class]])
            {
                //Synchronize the AtlasSprites position and rotation with the corresponding body
                    CCSprite *myActor = (CCSprite*)b->GetUserData();
                    myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
                    myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            }
		}
	}
    // BOX2D KRAM ENDE
    
        
    for(id node in FrameUpdateAbles)
    {
        if([node respondsToSelector:@selector(FrameUpdate:)])
            [node FrameUpdate:delta];
    }
    

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

    schlangeLayer._body->SetActive(false);

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
            schlangeLayer._body->SetActive(true);

        
            [schlangeLayer.schlange setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange0"]];
            schlangeLayer.schlangeInAir = YES;
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

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
    
    //---------- ASTKATAPULT
    if([ast isKindOfClass:[AstKatapult class]])
    {
        if(![(AstKatapult*)ast abgefeuert])
        {
            ((AstKatapult*)ast).baseLevelPtr = self;
            [self stopAllActions];
            [schlangeLayer moveSchlangeTo:ast.fangRadius.position];
            // Das Physikhandling nach der Animation usw. wird von der Astkatapult klasse geregelt. 
            
        }
        else
        {
            [self stopAllActions];
            [schlangeLayer moveSchlangeTo:ast.fangRadius.position];
        }
        
    }
    //---------- /ASTKATAPULT   
    
    //---------- RUTSCHIGER AST
    if([ast isKindOfClass:[Rutschiger_Ast class]])
    {
        if(schlangeLayer.schlangeState == SchlangeStateHarz)
        {
            [self stopAllActions];
            [schlangeLayer setSchlangeStateNormal];
        }
        else
        {
            schlangeLayer.schlangeInAir = YES;
            [self schedule:@selector(setSchlangeActive) interval:0.1];
        }
        
    }
    //---------- /RUTSCHIGER AST
    
    
    [ast AstWurdeBesucht];

}
-(void)schlangeTot
{
    if(!schlangeTot)
    {
        schlangeTot = YES;
        [self unschedule:@selector(restartLevel)];
        [self schedule:@selector(restartLevel) interval:1.5];
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
        schlangeLayer._body->SetActive(true);
        
        schlangeLayer.schlangeInAir = YES;
        [schlangeLayer.schlange setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange0"]];
    }
}
-(AstNormal*)getSchlangeAst
{
    return astLayer.lastAst;
}
-(CGPoint)getSchlangePosition
{
    return schlangeLayer.schlange.position;
}
-(void)setSchlangeInAir:(BOOL)schlangeInAir
{
    schlangeLayer.schlangeInAir = schlangeInAir;
}
-(void)setSchlangeActive
{
    [self unschedule:@selector(setSchlangeActive)];
    schlangeLayer._body->SetActive(true);
}
-(void)setSchlangeInActive
{
    schlangeLayer._body->SetActive(false);
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
}
-(BOOL)getTouchStartedOnSchlange
{
    return touchStartedOnSchlange;
}
-(NSMutableSet *)getAeste
{
    return astLayer.aeste;
}
-(SchlangeLayer *)getSchlangeLayer
{
    return schlangeLayer;
}

@end
