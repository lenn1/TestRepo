//
//  CPPinJoint.h
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "../CPConstraint.h"


@interface CPSlideJoint : CPConstraint {

}

+ (id) slideJointWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_ min:(cpFloat)min_ max:(cpFloat)max_;

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_ min:(cpFloat)min_ max:(cpFloat)max_;

@property(nonatomic, readonly) cpVect anchor1;
@property(nonatomic, readonly) cpVect anchor2;
@property(nonatomic, readonly) cpFloat min;
@property(nonatomic, readonly) cpFloat max;

@end
