//
//  AffeDelegate.h
//  Snake Escape
//
//  Created by Lennart Hansen on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AffeDelegate <NSObject>
@required
-(NSMutableSet*)getAeste;
@end
