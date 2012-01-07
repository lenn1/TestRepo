//
//  CPPinJoint.m
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "../CPBody.h"

#import "CPDampedSpring.h"


@implementation CPDampedSpring

+ (id) dampedSpringWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ anchors:(cpVect)anchor1_ :(cpVect)anchor2_
				   restLength:(cpFloat)restLength_ stiffness:(cpFloat)stiffness_ andDamping:(cpFloat)damping_ {
	return [[[self alloc] initWithBodies:bodyA_ :bodyB_ anchors:anchor1_ :anchor2_
							  restLength:restLength_ stiffness:stiffness_ andDamping:damping_] autorelease];
}

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ anchors:(cpVect)anchor1_ :(cpVect)anchor2_
		   restLength:(cpFloat)restLength_ stiffness:(cpFloat)stiffness_ andDamping:(cpFloat)damping_ {
	if ((self = [self init])) {
		cpconstraint = cpDampedSpringNew(bodyA_.cpbody, bodyB_.cpbody, anchor1_, anchor2_, restLength_, stiffness_, damping_);
		cpconstraint->data = self;
	}
	
	return self;
}

- (cpVect) anchor1 {
	return cpDampedSpringGetAnchr1(cpconstraint);
}

- (cpVect) anchor2 {
	return cpDampedSpringGetAnchr2(cpconstraint);
}

- (cpFloat) restLength {
	return cpDampedSpringGetRestLength(cpconstraint);
}

- (cpFloat) stiffness {
	return cpDampedSpringGetStiffness(cpconstraint);
}

- (cpFloat) damping {
	return cpDampedSpringGetDamping(cpconstraint);
}

@end
