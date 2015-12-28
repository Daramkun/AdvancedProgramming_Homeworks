//
//  FaceView.m
//  Happiness
//
//  Created by 다람군 on 12. 3. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@interface FaceView()

- (void) drawCircleAtPoint:(CGPoint)p 
                withRadius:(CGFloat)radius
                   context:(CGContextRef)context;

@end

@implementation FaceView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void) drawCircleAtPoint:(CGPoint)p 
                withRadius:(CGFloat)radius
                   context:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2 * M_PI, 1);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width / 2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height / 2;
    
    CGFloat faceRadius = self.bounds.size.width / 2;
    if(self.bounds.size.width > self.bounds.size.height)
    {
        faceRadius = self.bounds.size.height / 2;
    }
    faceRadius *= 0.9f;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midPoint withRadius:faceRadius context:context];
    
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.1
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - faceRadius * EYE_H;
    eyePoint.y = midPoint.y - faceRadius * EYE_V;
    [self drawCircleAtPoint:eyePoint withRadius:faceRadius * EYE_RADIUS context:context];
    eyePoint.x += faceRadius * EYE_H * 2;
    [self drawCircleAtPoint:eyePoint withRadius:faceRadius * EYE_RADIUS context:context];
    
#define MOUTH_H 0.45
#define MOUTH_V 0.4
#define MOUTH_SMILE 0.25
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - MOUTH_H * faceRadius;
    mouthStart.y = midPoint.y + MOUTH_V * faceRadius;
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += MOUTH_H * faceRadius * 2;
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += MOUTH_H * faceRadius * 2 / 2;
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= MOUTH_H * faceRadius * 2 / 3;
    
    float smile = [self.delegate smileForFaceView:self];
    if(smile <= -1.0) smile = -1.0;
    if(smile >= 1.0) smile = 1.0;
    
    CGFloat smileOffset = MOUTH_SMILE * faceRadius * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, 
                             mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
}

- (void) dealloc
{
    [super dealloc];
}

@end
