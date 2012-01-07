//
//  CPPinJoint.h
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "../CPConstraint.h"


@interface CPDampedSpring : CPConstraint {

}

+ (id) dampedSpringWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ anchors:(cpVect)anchor1_ :(cpVect)anchor2_
				   restLength:(cpFloat)restLength_ stiffness:(cpFloat)stiffness_ andDamping:(cpFloat)damping_;

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ anchors:(cpVect)anchor1_ :(cpVect)anchor2_
		   restLength:(cpFloat)restLength_ stiffness:(cpFloat)stiffness_ andDamping:(cpFloat)damping_;

@property(nonatomic, readonly) cpVect anchor1;
@property(nonatomic, readonly) cpVect anchor2;
@property(nonatomic, readonly) cpFloat restLength;
@property(nonatomic, readonly) cpFloat stiffness;
@property(nonatomic, readonly) cpFloat damping;

@end
