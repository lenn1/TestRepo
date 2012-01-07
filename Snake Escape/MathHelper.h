//
//  MathHelper.h
//  Snake Escape
//
//  Created by Lennart Hansen on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MathHelper : NSObject
+(CGFloat)distanceBetween:(CGPoint)A und:(CGPoint)B;
+(BOOL)IsCGPoint:(CGPoint)p2 InRadius:(CGFloat)radius OfPoint:(CGPoint)p2;
+(CGPoint)getVektorFromPoint:(CGPoint)a toPoint:(CGPoint)b;
+(CGFloat)getRotationOfVektor:(CGPoint)vektor;

@end
