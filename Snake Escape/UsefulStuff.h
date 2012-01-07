//
//  UsefulStuff.h
//  Snake Escape
//
//  Created by Lennart Hansen on 06.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UsefulStuff : CCNode {
    
}
+(CCRenderTexture*) createStrokeTTF: (CCLabelTTF*) label   size:(float)size   color:(ccColor3B)cor;
+(CCRenderTexture*) createStrokeBMFont: (CCLabelBMFont*) label   size:(float)size   color:(ccColor3B)cor;
@end
