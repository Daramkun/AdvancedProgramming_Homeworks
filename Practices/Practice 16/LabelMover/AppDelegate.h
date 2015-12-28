//
//  AppDelegate.h
//  LabelMover
//
//  Created by 진 재연 on 12. 5. 30..
//  Copyright (c) 2012년 daramkun@daram.pe.kr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CMMotionManager * motionManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (readonly) CMMotionManager* motionManager;

@end
