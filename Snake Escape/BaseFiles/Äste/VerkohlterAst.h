//
//  VerkohlterAst.h
//  Snake Escape
//
//  Created by Lennart Hansen on 15.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AstNormal.h"

@class VerkohlterAst;
@protocol VerkohlterAstDelegate <NSObject>
@optional
-(void)VerkohlterAstTimelimitIsUp:(VerkohlterAst*)ast;
@end
@interface VerkohlterAst : AstNormal 
{
    id <VerkohlterAstDelegate> delegate;
    BOOL astBroken;
    BOOL TimerAlreadyStarted;    
}
-(void)TimelimitIsUp;
-(BOOL)astBroken;
@property(readwrite,assign)id<VerkohlterAstDelegate>delegate;
@end
