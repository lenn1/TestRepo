//
//  CPBody.h
//  Shapes
//
//  Created by Torben on 14.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"


@class CPSpace;

@interface CPBody : NSObject {
	NSObject* data;
	CPSpace* space;
	
	cpBody* cpbody;
}

+ (id)body;
+ (id)bodyWithMass:(cpFloat)m andMoment:(cpFloat)i;

- (id)initWithMass:(cpFloat)m andMoment:(cpFloat)i;

- (void)applyImpulse:(cpVect)j atOffset:(cpVect)r;
- (void)appyForce:(cpVect)f atOffset:(cpVect)r;
- (void)applyDampedSpring:(cpFloat)rlen :(cpFloat)k :(cpFloat)dmp atOwnAnchor:(cpVect)anchr1 andBody:(cpBody*)b atAnchor:(cpVect)anchr2 inTime:(cpFloat)dt;

- (cpVect)convertLocalToWorld:(cpVect)v;
- (cpVect)convertWorldToLocal:(cpVect)v;

- (void)slewToPosition:(cpVect)pos inTime:(cpFloat)dt;

@property(nonatomic) cpFloat mass;
@property(nonatomic) cpFloat moment; 
@property(nonatomic) cpVect force; 
@property(nonatomic) cpVect position; 
@property(nonatomic) cpVect velocity;

@property(nonatomic) cpFloat radAngle;
@property(nonatomic) cpFloat degAngle;
@property(nonatomic) cpFloat angularVelocity;
@property(nonatomic) cpFloat torque;
@property(nonatomic, readonly) cpVect rotation;

@property(nonatomic, retain) NSObject* data;
@property(nonatomic, assign) CPSpace* space;

@property(nonatomic, readonly) cpBody* cpbody;

@end
