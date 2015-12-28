//
//  FaceView.h
//  Happiness
//
//  Created by 다람군 on 12. 3. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDelegate
- (float) smileForFaceView: (FaceView *)requestor;
@end

@interface FaceView : UIView
{
    id<FaceViewDelegate> _delegate;
    CGFloat _scale;
}

@property (assign) id<FaceViewDelegate> delegate;
@property (assign) CGFloat scale;

@end
