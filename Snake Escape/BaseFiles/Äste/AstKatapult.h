//
//  AstKatapult.h
//  Snake Escape
//
//  Created by Lennart Hansen on 21.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AstNormal.h"
#import "BaseLevel.h"
@class BaseLevel;
@interface AstKatapult : AstNormal
{
    BOOL abgefeuert;
    BaseLevel* baseLevelPtr;
    uint animateState;
}
@property(readonly)BOOL abgefeuert;
@property(assign,nonatomic)BaseLevel* baseLevelPtr;

@end
