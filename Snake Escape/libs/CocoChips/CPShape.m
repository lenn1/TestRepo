//
//  CPShape.m
//  Shapes
//
//  Created by Torben on 14.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CPBody.h"

#import "CPShape.h"


@implementation CPShape

+ (id) shapeCircleWithBody:(CPBody*)b Radius:(cpFloat)r andOffset:(cpVect)o {
	return [[[self alloc] initCircleWithBody:b Radius:r andOffset:o] autorelease];
}
+ (id) shapeSegmentWithBody:(CPBody*)b Endpoints:(cpVect)x :(cpVect)y andRadius:(cpFloat)r {
	return [[[self alloc] initSegmentWithBody:b Endpoints:x :y andRadius:r] autorelease];
}
+ (id) shapePolygonWithBody:(CPBody*)b Vertices:(cpVect*)v :(int)n andOffset:(cpVect)o {
	return [[[self alloc] initPolygonWithBody:b Vertices:v :n andOffset:o] autorelease];
}

- (id) init {
	if ((self = [super init])) {
		data = nil;
		space = nil;
		cpshape = NULL; // NOTE: NULL for c-pointers.
	}
	
	return self;
}

- (id) initCircleWithBody:(CPBody*)b Radius:(cpFloat)r andOffset:(cpVect)o {
	if ((self = [self init])) {
		[b retain];
		cpshape = cpCircleShapeNew(b.cpbody, r, o);
		cpshape->data = self;
	}

	return self;
}
- (id) initSegmentWithBody:(CPBody*)b Endpoints:(cpVect)x :(cpVect)y andRadius:(cpFloat)r {
	if ((self = [self init])) {
		[b retain];
		cpshape = cpSegmentShapeNew(b.cpbody, x, y, r);
		cpshape->data = self;
	}
	
	return self;
}
- (id) initPolygonWithBody:(CPBody*)b Vertices:(cpVect*)v :(int)n andOffset:(cpVect)o {
	if ((self = [self init])) {
		[b retain];
		cpshape = cpPolyShapeNew(b.cpbody, n, v, o);
		cpshape->data = self;
	}
	
	return self;
}

- (id) initCircleWithMass:(cpFloat)m Radius:(cpFloat)r andOffset:(cpVect)o {
	CPBody* b = [CPBody bodyWithMass:m andMoment:cpMomentForCircle(m, 0, 2*r, o)];
	return [self initCircleWithBody:b Radius:r andOffset:o];
}
- (id) initSegmentWithMass:(cpFloat)m Endpoints:(cpVect)x :(cpVect)y andRadius:(cpFloat)r {
	CPBody* b = [CPBody bodyWithMass:m andMoment:cpMomentForSegment(m, x, y)];
	return [self initSegmentWithBody:b Endpoints:x :y andRadius:r];
}
- (id) initPolygonWithMass:(cpFloat)m Vertices:(cpVect*)v :(int)n andOffset:(cpVect)o {
	CPBody* b = [CPBody bodyWithMass:m andMoment:cpMomentForPoly(m, n, v, o)];
	return [self initPolygonWithBody:b Vertices:v :n andOffset:o];
}

- (void) dealloc {
	NSLog(@"CPShape.dealloc"); // DEBUG
	
	[data release];
	[self.body release];
	
	if (cpshape)
		cpShapeFree(cpshape);
	
	[super dealloc];
}

// INFO: Getter & setter for generic properties

- (cpBB) box {
	return cpShapeCacheBB(cpshape);
}

- (BOOL) sensor {
	if (cpshape->sensor == 0)
		return NO;
	else
		return YES;
}
- (void) setSensor:(BOOL)x {
	if (x)
		cpshape->sensor = 1;
	else 
		cpshape->sensor = 0;
}

// INFO Getter & setter for physical properties

- (cpFloat) elasticity {
	return cpshape->e;
}
- (void) setElasticity:(cpFloat)e {
	cpshape->e = e;
}

- (cpFloat) friction {
	return cpshape->u;
}
- (void) setFriction:(cpFloat)x {
	cpshape->u = x;
}

- (cpVect) surfaceVelocity {
	return cpshape->surface_v;
}
- (void) setSurfaceVelocity:(cpVect)x {
	cpshape->surface_v = x;
}

// INFO: Getter & setter for anglular properties

- (cpGroup) collisionGroup {
	return cpshape->group;
}
- (void) setCollisionGroup:(cpGroup)x {
	cpshape->group = x;
}

- (cpLayers) collisionLayers {
	return cpshape->layers;
}
- (void) setCollisionLayers:(cpLayers)x {
	cpshape->layers = x;
}

- (cpCollisionType) collisionType {
	return cpshape->collision_type;
}
- (void) setCollisionType:(cpCollisionType)x {
	cpshape->collision_type = x;
}

// INFO: Getter & setter for linking properties

- (CPBody*) body {
	if( (cpshape) && (cpshape->body))
		return (CPBody*) cpshape->body->data;
	else
		return nil;
}

@synthesize data;
@synthesize space;

@synthesize cpshape;

@end
