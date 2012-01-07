//
//  BackgroundLayer.h
//  Snake Escape
//
//  Created by Lennart Hansen on 18.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface BackgroundLayer : CCLayer
{
    CGFloat levelWidth;
}
-(id)initWithLevelWidth:(CGFloat)Width AndHeight:(CGFloat)Height AndImageFile:(NSString*)imageFile;
@end
