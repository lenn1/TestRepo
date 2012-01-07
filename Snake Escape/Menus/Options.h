//
//  Options.h
//  Snake Escape
//
//  Created by Lennart Hansen on 20.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Options : CCLayer 
{
    CCMenu *menu;
    CCMenuItemImage *menuItem1;
}
+(CCScene*) scene;
-(void)goToMainMenu;
@end
