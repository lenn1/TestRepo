//
//  AstNormal.h
//  Snake Escape
//
//  Created by Lennart Hansen on 14.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
typedef struct 
{
    CGFloat radius;
    CGPoint position;
    
} Radius;

@interface AstNormal : CCSprite 
{
    NSString* name;
    Radius fangRadius;
    BOOL astAktiv;
    BOOL visitable;
    b2World* world;
}
-(void)AstWurdeBesucht;
-(void)setDelegate:(id)delegate;
-(void)changeImageToActive;
@property(readonly,assign)NSString* name;
@property(readonly)Radius fangRadius;
@property(readwrite)BOOL astAktiv;
@property(readwrite)BOOL visitable;
@property(readwrite)b2World* world;

@end
