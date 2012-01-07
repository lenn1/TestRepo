//
//  Credits.h
//  Snake Escape
//
//  Created by Lennart Hansen on 20.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Credits : CCLayer <CCTargetedTouchDelegate>
{
    CCSprite* credits;
    CGSize size;
    BOOL singletap;
}
+(CCScene*) scene;
-(void)repeater;
@end
