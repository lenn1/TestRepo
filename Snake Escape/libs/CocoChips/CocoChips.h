//
//  CocoChips.h
//  Shapes
//
//  Created by Torben on 14.07.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"

// INFO: cocos2d extensions

#import "COLayerDelegate.h"
#import "COSceneProtocol.h"

#import "COLayer.h"
#import "COScene.h"

// INFO: Chipmunk Objective-C wrapper

#import "CPBody.h"
#import "CPShape.h"
#import "CPConstraint.h"
#import "CPSpace.h"

#import "./CPConstraints/CPPinJoint.h"
#import "./CPConstraints/CPSlideJoint.h"
#import "./CPConstraints/CPPivotJoint.h"
#import "./CPConstraints/CPGrooveJoint.h"
#import "./CPConstraints/CPDampedSpring.h"
// TODO: Add missing constraints