//LEVEL 2

#import "Level1_5.h"
#import "Level1_6.h"
@implementation Level1_5


+(CCScene*)scene
{
    return [[Level1_5 alloc]initWithBackGroundImageFile:@"Level1_5.png" AndLevelWidth:480];

}
+(NSArray *)getNeededHighScores
{
    NSNumber* oneStar = [NSNumber numberWithInt:5000];
    NSNumber* twoStars = [NSNumber numberWithInt:10000];
    NSNumber* threeStars = [NSNumber numberWithInt:13000];
    return [NSArray arrayWithObjects:oneStar,twoStars,threeStars, nil];
    
}
-(void)LevelSetup
{
    
    levelPack = 1;
  
    self.levelTimeout = 20;


    [schlangeLayer setSchlangePosition:ccp(200, 230)];
    
    
    AstNormal* ast1 = [[AstNormal alloc]init];
    ast1.position = ccp(200,150);
    
    AstNormal* ast4 = [[AstNormal alloc]init];
    ast4.position = ccp(260,50);
    
    
    AstHindernis* ast2 = [[AstHindernis alloc]initWithWorld:world];
    ast2.position = ccp(200,50);
    ast2.rotation = 180;
    
    AstSchalter* ast3 = [[AstSchalter alloc]initWithTarget:ast2 AndRotation:180 AndPosition:ccp(0, 0)];
                                                                                           
    ast3.position = ccp(100,250);
    
    PortalExit* portal = [[PortalExit alloc]init];
    portal.position = ccp(400,50);
    
    [astLayer addAeste:ast1,ast2,ast3,ast4,portal,nil];
    [astLayer reorderChild:ast2 z:ast4.zOrder+1]; // damit das asthindernis sich über den Ast und nicht unter durch dreht  
}

-(void)nextLevel
{
    [[CCDirector sharedDirector]replaceScene:[Level1_6 scene]];
    
}


@end
