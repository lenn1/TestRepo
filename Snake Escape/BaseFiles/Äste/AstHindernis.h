//
//  AstHindernis.h
//  Snake Escape
//
//  Created by Lennart Hansen on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AstNormal.h"
#import "CocoChips.h"

@interface AstHindernis : AstNormal 
{
    CPSpace* space;
    CPShape* shape;
    CPShape* shape2;
    CPShape* shape3;
    CPShape* shape4;
    CPBody* body;

}
@end
