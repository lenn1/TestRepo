//
//  CocoLayer.h
//  CocoChips Template
//
//  Created by Torben on 02.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

#import "COLayerDelegate.h"


@interface COLayer : CCLayer {
	NSObject<COLayerDelegate>* delegate;
}

@property(assign) NSObject<COLayerDelegate>* delegate;

@end
