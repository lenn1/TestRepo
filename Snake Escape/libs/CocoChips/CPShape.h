//
//  CPShape.h
//  Shapes
//
//  Created by Torben on 14.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"


@class CPBody;
@class CPSpace;

@interface CPShape : NSObject {
	CPBody* body;
	NSObject* data;	
	CPSpace* space;

	cpShape* cpshape;
}

+ (id)shapeCircleWithBody:(CPBody*)b Radius:(cpFloat)r andOffset:(cpVect)o;
+ (id)shapeSegmentWithBody:(CPBody*)b Endpoints:(cpVect)x :(cpVect)y andRadius:(cpFloat)r;
+ (id)shapePolygonWithBody:(CPBody*)b Vertices:(cpVect*)v :(int)n andOffset:(cpVect)o;

- (id)initCircleWithBody:(CPBody*)b Radius:(cpFloat)r andOffset:(cpVect)o;
- (id)initSegmentWithBody:(CPBody*)b Endpoints:(cpVect)a :(cpVect)b andRadius:(cpFloat)r;
- (id)initPolygonWithBody:(CPBody*)b Vertices:(cpVect*)v :(int)n andOffset:(cpVect)o;
- (id)initCircleWithMass:(cpFloat)m Radius:(cpFloat)r andOffset:(cpVect)o;
- (id)initSegmentWithMass:(cpFloat)m Endpoints:(cpVect)x :(cpVect)y andRadius:(cpFloat)r;
- (id)initPolygonWithMass:(cpFloat)m Vertices:(cpVect*)v :(int)n andOffset:(cpVect)o;

@property(nonatomic, readonly) cpBB box;
@property(nonatomic) BOOL sensor;

@property(nonatomic) cpFloat elasticity;
@property(nonatomic) cpFloat friction;
@property(nonatomic) cpVect surfaceVelocity;

@property(nonatomic) cpGroup collisionGroup;
@property(nonatomic) cpLayers collisionLayers;
@property(nonatomic) cpCollisionType collisionType;

@property(nonatomic, readonly) CPBody* body;
@property(nonatomic, retain) NSObject* data;
@property(nonatomic, assign) CPSpace* space;

@property(nonatomic, readonly) cpShape* cpshape;

@end
