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
@synthesize schlange,delegate,schlangeInAir,body,shape,aufziehsound;
#define schlangeScale 0.8
-(id)initWithLevelWidth:(CGFloat)Width
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
    

        
        //PHYSIK
        
        body = [[CPBody alloc] initWithMass:1.0 andMoment:cpMomentForCircle(1.0, 28.5*schlangeScale, 0, CGPointZero)];
        body.position = ccp(schlange.position.x, schlange.position.y);
        body.data = self;
        
        shape = [[CPShape alloc ]initCircleWithBody:body Radius:28.5*schlangeScale andOffset:CGPointZero];
        shape.friction = 0.5;
        shape.elasticity = 0.5;
        

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
    if([delegate IsPhysicsEnabled])
    {
        [space step:delta];
        [schlange setPosition: body.position];
        [schlange setRotation: -body.degAngle];
    }
    
    if(schlange.position.y < -30 && [delegate respondsToSelector:@selector(schlangeTot)])
        [delegate schlangeTot];
}
-(void)moveSchlangeTo:(CGPoint)position
{
    body.position = position;
    body.angularVelocity = 0;
    body.velocity = ccp(0, 0);
    schlangeInAir = NO;
    [schlange runAction:[CCMoveTo actionWithDuration:0.1 position:position]];

}
-(void)moveSchlangeTo:(CGPoint)position WithDelay:(CGFloat)delay AndDuration:(CGFloat)duration
{
    CCDelayTime* delayAction = [CCDelayTime actionWithDuration:delay];
    CCMoveTo* moveAction = [CCMoveTo actionWithDuration:duration position:position];
    CCSequence* seq = [CCSequence actions:delayAction,moveAction, nil];
    [schlange runAction:seq];
    
    body.position = position;
    body.angularVelocity = 0;
    body.velocity = ccp(0, 0);
    schlangeInAir = NO;
}
-(void)setSchlangePosition:(CGPoint)position
{
    schlange.position = position;
    body.position = position;
    body.angularVelocity = 0;
    body.velocity = ccp(0, 0);
}

-(void)onEnter
{
        schlangeInAir = NO;
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
        space = [CPSpace sharedSpace];
        [space addBodyAndShape:shape];
        CCFiniteTimeAction* scaleAction = [CCScaleTo actionWithDuration:0.5 scale:schlangeScale];
        CCSequence* spawnSequence = [CCSequence actions:scaleAction,nil];
        [schlange runAction:spawnSequence];
        body.angularVelocity = -20;
        [super onEnter];
    


}
-(void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [space removeBodyAndShape:shape];
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
            body.velocity = cpv(-vx*5,-vy*5);
            body.angularVelocity = 10.0;
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
       /* CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"schlangeflug.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [schlange setTexture:texture];
        [schlange setTextureRect:rect];
        */
        
        [schlange setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"schlange0"]];
        [[SimpleAudioEngine sharedEngine]stopEffect:aufziehsound];
        
        if([touch tapCount] == 2)
        {
            if([self.delegate respondsToSelector:@selector(touchEndedOnSchlange)])
            [[self delegate]touchEndedOnSchlange];
            body.angularVelocity = 10.0;
            schlangeInAir = YES;
        }

    }
    touchStartedOnSchlange = NO;
    

    
    
}
@end
