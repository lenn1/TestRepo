//
//  AstSchalter.h
//  Snake Escape
//
//  Created by Lennart Hansen on 05.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AstNormal.h"
#import "SchlangeLayer.h"

@interface AstSchalter : AstNormal 
{
    CGFloat toRotation;
    CGPoint toPosition;
    AstNormal* target;
    BOOL schalterUnten;
}
- (id)initWithTarget:(AstNormal*)ast AndRotation:(CGFloat)rotation AndPosition:(CGPoint)position;
@property (readwrite) BOOL schalterUnten;
@end
