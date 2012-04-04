//
//  SchlangeLayer.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SchlangeLayer.h"
#import "MathHelper.h"

@implementation SchlangeLayer
@synthesize schlange,delegate,schlangeInAir,_body,aufziehsound;
#define schlangeScale 0.8
#define moveSchlangeToActionTag 998877
-(id)initWithLevelWidth:(CGFloat)Width AndWorld:(b2World*)worldptr
{
    if(self=[super init])
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"schlangeLangZiehenSpriteSheet.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"schlangeLangZiehenSpriteSheet.png"];
        [schlange addChild:spriteSheet];
        
        abschussradius = 80;
        touchStartedOnSchlange = NO;
        levelWidth = Width;
        schlange = [CCSprite spriteWithSpriteFrameName:@"schlange0"];
        schlange.scale = 0.01;
        [self addChild:schlange];
    

        //BOX2D
        world = worldptr;
        
        b2BodyDef ballBodyDef;
        ballBodyDef.type = b2_dynamicBody;
        ballBodyDef.position.Set(schlange.position.x/PTM_RATIO, schlange.position.y/PTM_RATIO);
        _body = world->CreateBody(&ballBodyDef);
        _body->SetUserData(self);
        b2CircleShape circle;
        circle.m_radius = 24.5/PTM_RATIO;
        
        b2FixtureDef ballShapeDef;
        ballShapeDef.shape = &circle;
        ballShapeDef.density = 1.0f;
        ballShapeDef.friction = 0.6f;
        ballShapeDef.restitution = 0.1f;
        b2MassData* mass = new b2MassData();
        mass->mass = 1.0;
        mass->center = b2Vec2(0.0,0.0);
        _body->SetMassData(mass);
        _body->CreateFixture(&ballShapeDef);
        

    }
    return self;
}
-(void)runSchlangMovesToAstAnimationWithAst:(AstNormal*)ast
{




    NSMutableArray *frames = [NSMutableArray array];
    for(int i = 1; i <= 6 ; i++) 
    {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%d", i]]];
    }
    for(int i = 6; i >= 1 ; i--) 
    {
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%d", i]]];
    }
    CCAnimation *schlangefaengtAst = [CCAnimation animationWithFrames:frames delay:0.0082f];
    CCAction* schlangeAnAstAction = [CCAnimate actionWithAnimation:schlangefaengtAst restoreOriginalFrame:YES];
    
    
    schlange.rotation = [MathHelper getRotationOfVektor:[MathHelper getVektorFromPoint:schlange.position toPoint:ast.position]];
    
    [schlange runAction:schlangeAnAstAction];
}



-(void)FrameUpdate:(ccTime)delta
{
        // BOX2D
        if(_body->IsActive())
        {
            [schlange setPosition: ccp(_body->GetPosition().x*PTM_RATIO,_body->GetPosition().y*PTM_RATIO)];
            [schlange setRotation: -_body->GetAngle()*PTM_RATIO];
        }
    if(schlange.position.y < -30 && [delegate respondsToSelector:@selector(schlangeTot)])
        [delegate schlangeTot];
}
-(void)moveSchlangeTo:(CGPoint)position
{
    
    //BOX2D
    _body->SetTransform(b2Vec2(position.x/PTM_RATIO, position.y/PTM_RATIO), 0.0f);
    _body->SetAngularVelocity(0.0);
    _body->SetLinearVelocity(b2Vec2_zero);
    
    schlangeInAir = NO;
    CCMoveTo* move = [CCMoveTo actionWithDuration:0.1 position:position];
    move.tag = moveSchlangeToActionTag;
    [schlange runAction:move];
}
-(void)moveSchlangeTo:(CGPoint)position WithDelay:(CGFloat)delay AndDuration:(CGFloat)duration
{
    CCDelayTime* delayAction = [CCDelayTime actionWithDuration:delay];
    CCMoveTo* moveAction = [CCMoveTo actionWithDuration:duration position:position];
    CCSequence* seq = [CCSequence actions:delayAction,moveAction, nil];
    [schlange runAction:seq];
    schlangeInAir = NO;
    

    //BOX2D
    _body->SetTransform(b2Vec2(position.x/PTM_RATIO, position.y/PTM_RATIO), 0.0f);
    _body->SetAngularVelocity(0.0);
    _body->SetLinearVelocity(b2Vec2_zero);
    
    
    
}
-(void)setSchlangePosition:(CGPoint)position
{
    // falls es die action gerade gibt wird die schlange nicht fix positioniert
    if(![schlange getActionByTag:moveSchlangeToActionTag])
    schlange.position = position;

    //BOX2D
    _body->SetTransform(b2Vec2(position.x/PTM_RATIO,position.y/PTM_RATIO), 0.0);
    _body->SetAngularVelocity(0);
    _body->SetLinearVelocity(b2Vec2_zero);
}

-(void)onEnter
{
        schlangeInAir = NO;
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
        CCFiniteTimeAction* scaleAction = [CCScaleTo actionWithDuration:0.5 scale:schlangeScale];
        CCSequence* spawnSequence = [CCSequence actions:scaleAction,nil];

        [schlange runAction:spawnSequence];
    
    
        //BOX2D
        _body->SetAngularVelocity(-40.0);
    
        [super onEnter];
    


}
-(void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];

    [super onExit];
    

}
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CGPoint locationOnScreen = [touch locationInView: [touch view]];
    locationOnScreen = [[CCDirector sharedDirector] convertToGL: locationOnScreen];
    CGPoint locationInWorld = ccp(locationOnScreen.x-self.parent.position.x,locationOnScreen.y);
    if(CGRectContainsPoint(CGRectMake(schlange.boundingBox.origin.x-5, schlange.boundingBox.origin.y-5,schlange.boundingBox.size.width+10, schlange.boundingBox.size.height+10), locationInWorld))
    {
        if([delegate respondsToSelector:@selector(touchStartedOnSchlange)])
            [delegate touchStartedOnSchlange];
        touchStartedOnSchlange = YES;
        if(!schlangeInAir)
            aufziehsound = [[SimpleAudioEngine sharedEngine]playEffect:@"aufziehen.wav"];
    }

    return YES;
    
}
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(touchStartedOnSchlange && !schlangeInAir)
    {    
        // FÜR DEN KOPF BEIM LANGZIEHEN
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL: location];
        location = ccp(location.x-self.parent.position.x,location.y);
        [self setSchlangeLangGezogen:location];
    }
}
-(void)setSchlangeLangGezogen:(CGPoint)location
{
    
    float entfernung = [MathHelper distanceBetween:location und:schlange.position];
    float vx = location.x-schlange.position.x;
    float vy = location.y-schlange.position.y;
    float multiplikator = abschussradius/entfernung;
    vx = vx*multiplikator;
    vy = vy*multiplikator;
    
    if(vx>=0 && vy>=0)
    {
        schlange.rotation = -atan(vy/vx)*180/M_PI;
    }
    else if(vx<0 && vy>=0)
    {
        schlange.rotation = -((-atan(vy/-vx)*180/M_PI)+180);
    }
    else if(vx<0 && vy<0)
    {
        schlange.rotation = -((-atan(vy/-vx)*180/M_PI)+180);
    }
    else if(vx >=0 && vy<0)
    {
        schlange.rotation = -((-atan(vy/-vx)*180/M_PI));
    }

    
    CCSpriteFrame *texture;
    
    if(entfernung > 0 && entfernung < 53) texture = [[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange1"];
    else if(entfernung >= 53 && entfernung < 57) texture =[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange2"];
    else if(entfernung >= 57 && entfernung < 62) texture = [[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange3"];
    else if(entfernung >= 62 && entfernung < 68) texture = [[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange4"];
    else if(entfernung >= 68 && entfernung < 70) texture = [[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange5"];
    else if(entfernung >= 70 && entfernung < 75) texture = [[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange6"];
    else if(entfernung >= 75 && entfernung < 80) texture = [[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange7"];
    else if(entfernung >= 80 /*&& entfernung < 90*/ )texture = [[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange8"];
    /*else if(entfernung >= 90 && entfernung < 100) texture = [[CCTextureCache sharedTextureCache] addImage: @"schlange90.png"];
     else if(entfernung >= 100) texture = [[CCTextureCache sharedTextureCache] addImage: @"schlange100.png"];
     */
    
    [schlange setDisplayFrame:texture];

}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{

    
    if(touchStartedOnSchlange && !schlangeInAir)
    {
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL: location];
        location = ccp(location.x-self.parent.position.x,location.y);
        
        float entfernung = [MathHelper distanceBetween:location und:schlange.position];
        CGPoint temp;
        if(entfernung < abschussradius)
        {
            temp = location;
        }
        else
        {
            float xAbstand = location.x-schlange.position.x;
            float yAbstand = location.y-schlange.position.y;
            float multiplikator = abschussradius/entfernung;
            xAbstand = xAbstand*multiplikator;
            yAbstand = yAbstand*multiplikator;
            temp = ccp(xAbstand+schlange.position.x, yAbstand+schlange.position.y);
        }
        
        float vx = temp.x-schlange.position.x;
        float vy = temp.y-schlange.position.y;
        
        
        if(entfernung > 20)
        {
            // BOX2D
            _body->SetLinearVelocity(b2Vec2(-vx*5/PTM_RATIO,-vy*5/PTM_RATIO));
            _body->SetAngularVelocity(20);
            
            schlangeInAir = YES;
            [[SimpleAudioEngine sharedEngine]playEffect:@"Flitsch.wav"];
            if(touchStartedOnSchlange  && [self.delegate respondsToSelector:@selector(touchEndedOnSchlange)])
                [self.delegate touchEndedOnSchlange];

        }
        else
        {
            if ([[self delegate]respondsToSelector:@selector(schlangeAbschiessenCancel)])
                [[self delegate]schlangeAbschiessenCancel];
        }
        
        [schlange setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange0"]];
        [[SimpleAudioEngine sharedEngine]stopEffect:aufziehsound];
        
        if([touch tapCount] == 2)
        {
            if([self.delegate respondsToSelector:@selector(touchEndedOnSchlange)])
            [[self delegate]touchEndedOnSchlange];
            
            //BOX2D
            _body->SetAngularVelocity(20);
            
            schlangeInAir = YES;
        }

    }
    touchStartedOnSchlange = NO;
    

    
    
}
@end
