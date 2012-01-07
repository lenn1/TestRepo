//
//  CPTest.h
//  Contraints
//
//  Created by Torben on 07.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"


@class CPBody;
@class CPSpace;

@interface CPConstraint : NSObject {
	NSObject* data;
	CPSpace* space;
	
	cpConstraint* cpconstraint;
}

+ (id) constraint;

@property(nonatomic, readonly) CPBody* bodyA;
@property(nonatomic, readonly) CPBody* bodyB;
@property(nonatomic, readonly) cpFloat maxForce;
@property(nonatomic, readonly) cpFloat biasCoef;
@property(nonatomic, readonly) cpFloat maxBias;
@property(nonatomic, readonly) cpFloat impulse;

@property(nonatomic, retain) NSObject* data;
@property(nonatomic, assign) CPSpace* space;

@property(nonatomic, readonly) cpConstraint* cpconstraint;

@end
