//
//  HUDLayer.h
//  Snake Escape
//
//  Created by Lennart Hansen on 05.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface HUDLayer : CCLayer 
{
    CCSprite* Einer;
    CCSprite* Zehner;
    NSInteger _remainingTime;
}
-(void)decreaseTime;
@property NSInteger remainingTime;
@end
