//
//  CPBody.m
//  Shapes
//
//  Created by Torben on 14.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CPBody.h"


@implementation CPBody

+ (id) body {
	return [[[self alloc] init] autorelease];
}
+ (id) bodyWithMass:(cpFloat)m andMoment:(cpFloat)i {
	return [[[self alloc] initWithMass:m andMoment:i] autorelease];
}

- (id) init {
	if ((self = [super init])) {
		space = nil;
		cpbody =  NULL; // NOTE: NULL for c-pointers.
	}
	
	return self;
}
- (id) initWithMass:(cpFloat)m andMoment:(cpFloat)i {
	if ((self = [self init])) {
		cpbody = cpBodyNew(m, i);
		cpbody->data = self;
	}
	
	return self;
}

- (void) dealloc {
	//NSLog(@"CPBody.dealloc"); // DEBUG
	
	[data release];
	
	if (cpbody)
		cpBodyFree(cpbody);
	
	[super dealloc];
}

- (void) applyImpulse:(cpVect)j atOffset:(cpVect)r {
	cpBodyApplyImpulse(cpbody, j, r);
}
- (void) appyForce:(cpVect)f atOffset:(cpVect)r {
	cpBodyApplyForce(cpbody, f, r);
}
- (void) applyDampedSpring:(cpFloat)rlen :(cpFloat)k :(cpFloat)dmp atOwnAnchor:(cpVect)anchr1 andBody:(cpBody*)b atAnchor:(cpVect)anchr2 inTime:(cpFloat)dt { 
	cpApplyDampedSpring(cpbody, b, anchr1, anchr2, rlen, k, dmp, dt);
}

- (cpVect) convertLocalToWorld:(cpVect)v {
	return cpBodyLocal2World(cpbody, v);
}
- (cpVect) convertWorldToLocal:(cpVect)v {
	return cpBodyWorld2Local(cpbody, v);
}

- (void) resetFoces {
	cpBodyResetForces(cpbody);
}

- (void) slewToPosition:(cpVect)pos inTime:(cpFloat)dt {
	cpBodySlew(cpbody, pos, dt);
}

/*- (void) synchronize {
	if (node) {
		 // NOTE: Any method not found warnings here can be ignored
		[node setPosition: cpbody->p];
		[node setRotation:(-180.0*cpbody->a/M_PI)];
		
		if ([self.delegate respondsToSelector:@selector(bodyDidSynchronize:)])
			[self.delegate bodyDidSynchronize:self];
	}
}*/

- (void) updateVelocityWithGravity:(cpVect)gravity andDamping:(cpFloat)damping inTime:(cpFloat)dt {
	cpBodyUpdateVelocity(cpbody, gravity, damping, dt);
}
- (void) updatePositionInTime:(cpFloat)dt {
	cpBodyUpdatePosition(cpbody, dt);
}

// INFO: Getter & setter for generic properties

- (id) space {
	return space;
}
- (void) setSpace:(id)s {
	space = s;
}

// INFO: Getter & setter for mass properties

- (cpFloat) mass {
	return cpBodyGetMass(cpbody);
}
- (void) setMass:(cpFloat)m {
	cpBodySetMass(cpbody, m);
}

- (cpFloat) moment {
	return cpBodyGetMoment(cpbody);
}
- (void) setMoment:(cpFloat)i {
	cpBodySetMoment(cpbody, i);
}

// INFO: Getter & setter for positional properties

- (cpVect) force {
	return cpBodyGetForce(cpbody);
}
- (void) setForce:(cpVect)f {
	cpBodySetForce(cpbody, f);
}

- (cpVect) position {
	return cpBodyGetPos(cpbody);
}
- (void) setPosition:(cpVect)p {
	cpBodySetPos(cpbody, p);
}

- (cpVect) velocity {
	return cpBodyGetVel(cpbody);
}
- (void) setVelocity:(cpVect)v {
	cpBodySetVel(cpbody, v);
}

// INFO: Getter & setter for anglular properties

- (cpFloat)radAngle {
	return cpBodyGetAngle(cpbody);
}
- (void)setRadAngle:(cpFloat)rad_ {
	cpBodySetAngle(cpbody, rad_);
}

- (cpFloat)degAngle {
	return (cpBodyGetAngle(cpbody)*180.0)/M_PI;
}
- (void)setDegAngle:(cpFloat)deg_ {
	cpBodySetAngle(cpbody, (deg_/180.0)*M_PI);
}

- (cpFloat) angularVelocity {
	return cpBodyGetAngVel(cpbody);
}
- (void) setAngularVelocity:(cpFloat)w {
	cpBodySetAngVel(cpbody, w);
}

- (cpFloat) torque {
	return cpBodyGetTorque(cpbody);
}
- (void) setTorque:(cpFloat)t {
	cpBodySetTorque(cpbody, t);
}

- (cpVect) rotation {
	return cpBodyGetRot(cpbody);
}

// INFO: Getter & setter for linking properties

@synthesize data;
@synthesize space;

@synthesize cpbody;

@end
