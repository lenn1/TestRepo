//
//  StachelAst.h
//  Snake Escape
//
//  Created by Lennart Hansen on 23.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AstNormal.h"
@interface StachelAst : AstNormal 
{
    BOOL stachelAusgefahren;
    BOOL visibleOnScreen;
}
-(void)changeMode;
@property (readonly)BOOL stachelAusgefahren;
@end
