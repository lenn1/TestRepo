//
//  MathHelper.m
//  Snake Escape
//
//  Created by Lennart Hansen on 19.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MathHelper.h"
@implementation MathHelper
+(CGFloat)distanceBetween:(CGPoint)A und:(CGPoint)B
{
    return sqrtf(powf(B.x - A.x, 2)+powf(B.y-A.y, 2));
}

+(BOOL)IsCGPoint:(CGPoint)p1 InRadius:(CGFloat)radius OfPoint:(CGPoint)p2
{
    if([MathHelper distanceBetween:p1 und:p2] <= radius)
        return YES;
    else
        return NO;

}

+(CGPoint)getVektorFromPoint:(CGPoint)a toPoint:(CGPoint)b;
{
        return ccp(b.x-a.x,b.y-a.y);
}

+(CGFloat)getRotationOfVektor:(CGPoint)vektor;
{
    CGFloat vx = vektor.x;
    CGFloat vy = vektor.y;
    
    if(vx>=0 && vy>=0)
    {
    return -atan(vy/vx)*180/M_PI;
    }
    else if(vx<0 && vy>=0)
    {
        return -((-atan(vy/-vx)*180/M_PI)+180);
    }
    else if(vx<0 && vy<0)
    {
        return -((-atan(vy/-vx)*180/M_PI)+180);
    }
    else if(vx >=0 && vy<0)
    {
        return -((-atan(vy/-vx)*180/M_PI));
    }
    return 0;
}




@end
