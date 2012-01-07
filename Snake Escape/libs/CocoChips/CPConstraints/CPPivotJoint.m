//
//  CPPinJoint.m
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "../CPBody.h"

#import "CPPivotJoint.h"


@implementation CPPivotJoint

+ (id) pivotJointWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_  andPivot:(cpVect)pivot_ {
	return [[[self alloc] initWithBodies:bodyA_ :bodyB_  andPivot:pivot_] autorelease];
}

+ (id) pivotJointWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_ {
	return [[[self alloc] initWithBodies:bodyA_ :bodyB_ andAnchors:anchor1_ :anchor2_] autorelease];
}

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andPivot:(cpVect)pivot_ {
	if ((self = [self init])) {
		cpconstraint = cpPivotJointNew(bodyA_.cpbody, bodyB_.cpbody, pivot_);
		cpconstraint->data = self;
	}
	
	return self;
}

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_ {
	if ((self = [self init])) {
		cpconstraint = cpPivotJointNew2(bodyA_.cpbody, bodyB_.cpbody, anchor1_, anchor2_);
		cpconstraint->data = self;
	}
	
	return self;
}

- (cpVect) anchor1 {
	return cpPivotJointGetAnchr1(cpconstraint);
}

- (cpVect) anchor2 {
	return cpPivotJointGetAnchr2(cpconstraint);
}

@end
