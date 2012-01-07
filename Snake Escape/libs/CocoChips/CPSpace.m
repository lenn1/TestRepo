//
//  CPSpace.m
//  Shapes
//
//  Created by Torben on 14.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CPBody.h"
#import "CPShape.h"
#import "CPConstraint.h"

#import "CPSpace.h"


@implementation CPSpace

// INFO: Static C callback functions

static int divertBeginHandler(cpArbiter *arb, struct cpSpace *space, void *data) {
	CPCollisionDivert* divert = (CPCollisionDivert*)data;
	return (int) [divert->target performSelector:divert->beginSel withObject:(void*)arb withObject:divert->data];
}
static int divertPreSolveHandler(cpArbiter *arb, struct cpSpace *space, void *data) {
	CPCollisionDivert* divert = (CPCollisionDivert*)data;
	return (int) [divert->target performSelector:divert->preSolveSel withObject:(void*)arb withObject:divert->data];
}
static void divertPostSolveHandler(cpArbiter *arb, struct cpSpace *space, void *data) {
	CPCollisionDivert* divert = (CPCollisionDivert*)data;
	[divert->target performSelector:divert->postSolveSel withObject:(void*)arb withObject:divert->data];
}
static void divertSeparateHandler(cpArbiter *arb, struct cpSpace *space, void *data) {
	CPCollisionDivert* divert = (CPCollisionDivert*)data;
	[divert->target performSelector:divert->separateSel withObject:(void*)arb withObject:divert->data];
}

static void eachBodyIteration(cpBody* cpbody, void* data) {
	CPCollisionDivert* divert = (CPCollisionDivert*)data;
	[divert->target performSelector:divert->beginSel withObject:cpbody->data  withObject:divert->data];
}
static void eachShapeIteration(void *cpshape, void* data) {
	CPCollisionDivert* divert = (CPCollisionDivert*)data;
	[divert->target performSelector:divert->beginSel withObject:((cpShape*) cpshape)->data withObject:divert->data];
}

static void postStepRemoveBody(cpSpace *cpspace, cpBody *cpbody, void* unused) {
	cpSpaceRemoveBody(cpspace, cpbody);
	((CPBody*) cpbody->data).space = nil;
	[((CPBody*) cpbody->data) release];
}
static void postStepRemoveConstraint(cpSpace *cpspace, cpConstraint *cpconstraint, void* unused) {
	cpSpaceRemoveConstraint(cpspace, cpconstraint);
	((CPConstraint*) cpconstraint->data).space = nil;
	[((CPConstraint*) cpconstraint->data) release];
}
static void postStepRemoveShape(cpSpace *cpspace, cpShape *cpshape, void *unused) {
	cpSpaceRemoveShape(cpspace, cpshape);
	((CPShape*) cpshape->data).space = nil;
	[((CPShape*) cpshape->data) release];
}
static void postStepRemoveStaticShape(cpSpace *cpspace, cpShape *cpshape, void *unused) {
	cpSpaceRemoveStaticShape(cpspace, cpshape);
	((CPShape*) cpshape->data).space = nil;
	[((CPShape*) cpshape->data) release];
}

static void removeBodiesIteration(cpBody *body, void* this) {
	cpSpaceAddPostStepCallback(((CPSpace*) this).cpspace, (cpPostStepFunc)postStepRemoveBody, body, nil);
}
static void removeShapesIteration(void *shape, void* this) {
	cpSpaceAddPostStepCallback(((CPSpace*) this).cpspace, (cpPostStepFunc)postStepRemoveBody, ((CPShape*)((cpShape*)shape)->data).body.cpbody, nil);
	cpSpaceAddPostStepCallback(((CPSpace*) this).cpspace, (cpPostStepFunc)postStepRemoveShape, shape, nil);
}
static void removeStaticShapesIteration(void *shape, void* this) {
	cpSpaceAddPostStepCallback(((CPSpace*) this).cpspace, (cpPostStepFunc)postStepRemoveBody, ((CPShape*)((cpShape*)shape)->data).body.cpbody, nil);
	cpSpaceAddPostStepCallback(((CPSpace*) this).cpspace, (cpPostStepFunc)postStepRemoveStaticShape, shape, nil);
}

// INFO: Objective-C variables and methods

static CPSpace* sharedSpace = nil;

+ (id) sharedSpace {
    if (sharedSpace == nil)
        sharedSpace = [[self alloc] init];
    return sharedSpace;
}

- (id) init {
	if ((self = [super init])) {
        cpInitChipmunk();
        cpspace = cpSpaceNew();
	}
	
	return self;
}

- (void) dealloc {
	NSLog(@"CPSpace.dealloc"); // DEBUG
	
	[self removeAll];
	
	if (cpspace)
		cpSpaceFree(cpspace);
	
	[super dealloc];
}

- (void) removeAll {
	if (cpspace) {
		cpSpaceHashEach(cpspace->activeShapes, &removeShapesIteration, self);
		cpSpaceHashEach(cpspace->staticShapes, &removeStaticShapesIteration, self);
		cpSpaceEachBody(cpspace, &removeBodiesIteration, self);
	}
}
- (void) removeAllBodies {
	if (cpspace)
		cpSpaceEachBody(cpspace, &removeBodiesIteration, self);
}
- (void) removeAllShapes {
	if (cpspace)
		cpSpaceHashEach(cpspace->activeShapes, &removeShapesIteration, self);
}
- (void) removeAllStaticShapes {
	if (cpspace)
		cpSpaceHashEach(cpspace->staticShapes, &removeStaticShapesIteration, self);
}

- (void) addBody:(CPBody*)body_ {
	[body_ retain];
	cpSpaceAddBody(cpspace, body_.cpbody);
	body_.space = self;
}
- (void) addConstraint:(CPConstraint*)constraint {
	[constraint retain];
	cpSpaceAddConstraint(cpspace, constraint.cpconstraint);
	constraint.space = self;	
}
- (void) addShape:(CPShape*)shape {
	[shape retain];
	cpSpaceAddShape(cpspace, shape.cpshape);
	shape.space = self;	
}
- (void) addStaticShape:(CPShape*)shape {
	[shape retain];
	cpSpaceAddStaticShape(cpspace, shape.cpshape);
	shape.space = self;
}
- (void) addBodyAndShape:(CPShape*)shape {
	[self addBody:((CPBody*)shape.cpshape->body->data)];
	[self addShape:shape];
}

- (void) removeBody:(CPBody*)body {
	cpSpaceAddPostStepCallback(self.cpspace, (cpPostStepFunc)postStepRemoveBody, body.cpbody, NULL);
}
- (void) removeConstraint:(CPConstraint*)constraint {
	cpSpaceAddPostStepCallback(self.cpspace, (cpPostStepFunc)postStepRemoveConstraint, constraint.cpconstraint, NULL);
}
- (void) removeShape:(CPShape*)shape {
	cpSpaceAddPostStepCallback(self.cpspace, (cpPostStepFunc)postStepRemoveShape, shape.cpshape, NULL);
}
- (void) removeStaticShape:(CPShape*)shape {
	cpSpaceAddPostStepCallback(self.cpspace, (cpPostStepFunc)postStepRemoveStaticShape, shape.cpshape, NULL);
}
- (void) removeBodyAndShape:(CPShape*)shape {
	[self removeBody:((CPBody*)shape.cpshape->body->data)];
	[self removeShape:shape];
}

- (void) addCollisionForTypes:(cpCollisionType)a :(cpCollisionType)b withTarget:(id)target selectors:(SEL)beginSel :(SEL)preSolveSel :(SEL)postSolveSel :(SEL)separateSel andData:(void*)data {	
	cpCollisionBeginFunc beginFunc = (beginSel == nil) ? NULL : &divertBeginHandler;
	cpCollisionPreSolveFunc preSolveFunc = (preSolveSel == nil) ? NULL : &divertPreSolveHandler;
	cpCollisionPostSolveFunc postSolveFunc = (postSolveSel == nil) ? NULL : &divertPostSolveHandler;
	cpCollisionSeparateFunc separateFunc = (separateSel == nil) ? NULL : &divertSeparateHandler;

	struct{cpCollisionType a, b;} ids = {a, b};
	cpCollisionHandler *old_handler = cpHashSetFind(cpspace->collFuncSet, CP_HASH_PAIR(a, b), &ids);
	cpfree(old_handler->data);
	
	CPCollisionDivert* divert = (CPCollisionDivert*)cpcalloc(1, sizeof(CPCollisionDivert));
	divert->target = target;
	divert->beginSel = beginSel;
	divert->preSolveSel = preSolveSel;
	divert->postSolveSel = postSolveSel;
	divert->separateSel = separateSel;
	divert->data = data;
	
	cpSpaceAddCollisionHandler(cpspace, a, b, beginFunc, preSolveFunc, postSolveFunc, separateFunc, divert);
}
- (void) removeCollisionForTypes:(cpCollisionType)a :(cpCollisionType)b {
	struct{cpCollisionType a, b;} ids = {a, b};
	cpCollisionHandler *old_handler = cpHashSetFind(cpspace->collFuncSet, CP_HASH_PAIR(a, b), &ids);
	cpfree(old_handler->data);
	
	cpSpaceRemoveCollisionHandler(cpspace, a, b);
}

- (void) resizeActiveHash:(cpFloat)dim count:(int)count {
	cpSpaceResizeActiveHash(cpspace, dim, count);
}
- (void) resizeStaticHash:(cpFloat)dim count:(int)count {
	cpSpaceResizeActiveHash(cpspace, dim, count);
}

- (void) rehashStatic {
	cpSpaceRehashStatic(cpspace);	
}

- (void) step:(cpFloat)delta_ {
	cpSpaceStep(cpspace, delta_);
}

- (void) eachBodyWithTarget:(id)target_ selector:(SEL)selector_ andData:(void*)data_ {
	CPCollisionDivert* divert = (CPCollisionDivert*)cpcalloc(1, sizeof(CPCollisionDivert));
	divert->target = target_;
	divert->beginSel = selector_;
	divert->preSolveSel = nil;
	divert->postSolveSel = nil;
	divert->separateSel = nil;
	divert->data = data_;
	
	cpSpaceEachBody(cpspace, &eachBodyIteration, divert);
	cpfree(divert);
}

- (void) eachShapeWithTarget:(id)target_ selector:(SEL)selector_ andData:(void*)data_ {
	CPCollisionDivert* divert = (CPCollisionDivert*)cpcalloc(1, sizeof(CPCollisionDivert));
	divert->target = target_;
	divert->beginSel = selector_;
	divert->preSolveSel = nil;
	divert->postSolveSel = nil;
	divert->separateSel = nil;
	divert->data = data_;
	
	cpSpaceHashEach(cpspace->activeShapes, &eachShapeIteration, divert);
	cpfree(divert);
}

- (void) eachStaticShapeWithTarget:(id)target_ selector:(SEL)selector_ andData:(void*)data_ {
	CPCollisionDivert* divert = (CPCollisionDivert*)cpcalloc(1, sizeof(CPCollisionDivert));
	divert->target = target_;
	divert->beginSel = selector_;
	divert->preSolveSel = nil;
	divert->postSolveSel = nil;
	divert->separateSel = nil;
	divert->data = data_;
	
	cpSpaceHashEach(cpspace->staticShapes, &eachShapeIteration, divert);
	cpfree(divert);
}

// INFO: Getter & setter for gravity properties

- (cpFloat) damping {
	return cpspace->damping;
}
- (void) setDamping:(cpFloat)x {
	cpspace->damping = x;
}

- (cpVect) gravity {
	return cpspace->gravity;
}
- (void) setGravity:(cpVect)x {
	cpspace->gravity = x;
}

// INFO: Getter & setter for loop properties

- (NSInteger) elasticIterations {
	return cpspace->elasticIterations;
}
- (void) setElasticIterations:(NSInteger)x {
	cpspace->elasticIterations = x;
}

- (NSInteger) iterations {
	return cpspace->iterations;
}
- (void) setIterations:(NSInteger)x {
	cpspace->iterations = x;
}

@synthesize cpspace;

@end
