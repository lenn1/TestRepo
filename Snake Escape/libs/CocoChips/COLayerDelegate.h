//
//  CocoLayerDelegate.h
//  CocoChips Template
//
//  Created by Torben on 02.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class COLayer;

@protocol COLayerDelegate

@optional

- (void) layerDidAccelerate:(COLayer*)layer_ accelerometer:(UIAccelerometer*)accelerometer_ acceleration:(UIAcceleration*)acceleration_;

- (void) layerDidTouchBegan:(COLayer*)layer_ touch:(UITouch*)touch_ event:(UIEvent*)event_;
- (void) layerDidTouchEnded:(COLayer*)layer_ touch:(UITouch*)touch_ event:(UIEvent*)event_;
- (void) layerDidTouchMoved:(COLayer*)layer_ touch:(UITouch*)touch_ event:(UIEvent*)event_;

@end
