//
//  CPPinJoint.m
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "../CPBody.h"

#import "CPGrooveJoint.h"


@implementation CPGrooveJoint

+ (id) grooveJointWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ grooves:(cpVect)grooveA_ :(cpVect)grooveB_ andAnchor:(cpVect)anchor_ {
	return [[[self alloc] initWithBodies:bodyA_ :bodyB_ grooves:grooveA_ :grooveB_ andAnchor:anchor_] autorelease];
}

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ grooves:(cpVect)grooveA_ :(cpVect)grooveB_ andAnchor:(cpVect)anchor_ {
	if ((self = [self init])) {
		cpconstraint = cpGrooveJointNew(bodyA_.cpbody, bodyB_.cpbody, grooveA_, grooveB_, anchor_);
		cpconstraint->data = self;
	}
	
	return self;
}

- (cpVect) grooveA {
	return cpGrooveJointGetGrooveA(cpconstraint);
}

- (cpVect) grooveB {
	return cpGrooveJointGetGrooveB(cpconstraint);
}

- (cpVect) anchor {
	return cpGrooveJointGetAnchr2(cpconstraint);
}

@end
