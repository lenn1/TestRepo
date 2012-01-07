//
//  CPPinJoint.h
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "../CPConstraint.h"


@interface CPPinJoint : CPConstraint {

}

+ (id) pinJointWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_;

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ andAnchors:(cpVect)anchor1_ :(cpVect)anchor2_;

@property(nonatomic, readonly) cpVect anchor1;
@property(nonatomic, readonly) cpVect anchor2;
@property(nonatomic, readonly) cpFloat distance;

@end
