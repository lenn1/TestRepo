//
//  PortalExit.h
//  Snake Escape
//
//  Created by Lennart Hansen on 22.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AstNormal.h"
@protocol PortalExitDelegate <NSObject>
@optional
-(void)PortalErreicht;
@end
@interface PortalExit : AstNormal
{
    id<PortalExitDelegate>delegate;
    CCAction* portalLightsOn;
}
-(void)PortalCheck:(NSSet*)aeste;
@property(assign)id<PortalExitDelegate>delegate;
@end
