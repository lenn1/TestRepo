//
//  Vogel.h
//  Snake Escape
//
//  Created by Lennart Hansen on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "Box2D.h"
#import "SchlangeLayer.h"
#import "MathHelper.h"
typedef struct 
{
    CGFloat radius;
    CGPoint position;
    
} FangRadius;


@protocol VogelDelegate <NSObject>
@required
-(SchlangeLayer*)getSchlangeLayer;
@end

@interface Vogel : CCSprite
{
    NSString *name;
    FangRadius fangRadius;
    b2World* world;
    CGFloat maxLeft;
    CGFloat maxRight;
    BOOL directionRight;
    BOOL schlangeGefangen;
    BOOL schlangeVerlaesst;
    id<VogelDelegate> delegate;
    CGFloat abwurfPosition;
    CGFloat speed;
    
    
}
@property CGFloat maxRight;
@property CGFloat maxLeft;
@property CGFloat abwurfPosition;
@property CGFloat speed;
@property BOOL directionRight;
@property(assign,nonatomic)id<VogelDelegate>delegate;
-(void)FrameUpdate:(ccTime)delta;
-(CGFloat)XPositionInSeconds:(CGFloat)seconds;
@end
