//
//  CPSpace.h
//  Shapes
//
//  Created by Torben on 14.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"


@class CPBody;
@class CPShape;
@class CPConstraint;

typedef struct {
	id target;
	SEL	beginSel;
	SEL preSolveSel;
	SEL postSolveSel;
	SEL separateSel;
	void* data;
} CPCollisionDivert;

@interface CPSpace : NSObject {
	cpSpace* cpspace;
}

+ (id) sharedSpace;

- (void) removeAll;
- (void) removeAllBodies;
- (void) removeAllShapes;
- (void) removeAllStaticShapes;

- (void) addBody:(CPBody*)body_;
- (void) addBodyAndShape:(CPShape*)shape;
- (void) addConstraint:(CPConstraint*)constraint;
- (void) addShape:(CPShape*)shape;
- (void) addStaticShape:(CPShape*)shape;

- (void) removeBody:(CPBody*)body;
- (void) removeBodyAndShape:(CPShape*)shape;
- (void) removeConstraint:(CPConstraint*)constraint;
- (void) removeShape:(CPShape*)shape;
- (void) removeStaticShape:(CPShape*)shape;

- (void) addCollisionForTypes:(cpCollisionType)a :(cpCollisionType)b withTarget:(id)target selectors:(SEL)beginSel :(SEL)preSel :(SEL)postSel :(SEL)separateSel andData:(void*)data;
- (void) removeCollisionForTypes:(cpCollisionType)a :(cpCollisionType)b;

- (void) resizeActiveHash:(cpFloat)dim count:(NSInteger)count;
- (void) resizeStaticHash:(cpFloat)dim count:(NSInteger)count;

- (void) rehashStatic;
- (void) step:(cpFloat)delta_;

- (void) eachBodyWithTarget:(id)target_ selector:(SEL)selector_ andData:(void*)data_;
- (void) eachShapeWithTarget:(id)target_ selector:(SEL)selector_ andData:(void*)data_;
- (void) eachStaticShapeWithTarget:(id)target_ selector:(SEL)selector_ andData:(void*)data_;

@property(nonatomic) cpFloat damping;
@property(nonatomic) cpVect gravity;

@property(nonatomic) NSInteger iterations;
@property(nonatomic) NSInteger elasticIterations;

@property(nonatomic, readonly) cpSpace* cpspace;

@end
