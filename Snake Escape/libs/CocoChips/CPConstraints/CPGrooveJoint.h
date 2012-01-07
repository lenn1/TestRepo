//
//  CPPinJoint.h
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "../CPConstraint.h"


@interface CPGrooveJoint : CPConstraint {

}

+ (id) grooveJointWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ grooves:(cpVect)grooveA_ :(cpVect)grooveB_ andAnchor:(cpVect)anchor_;

- (id) initWithBodies:(CPBody*)bodyA_ :(CPBody*)bodyB_ grooves:(cpVect)grooveA_ :(cpVect)grooveB_ andAnchor:(cpVect)anchor_;

@property(nonatomic, readonly) cpVect grooveA;
@property(nonatomic, readonly) cpVect grooveB;
@property(nonatomic, readonly) cpVect anchor;

@end
