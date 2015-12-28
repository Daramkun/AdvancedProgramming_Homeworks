//
//  ViewController.h
//  Happiness
//
//  Created by 다람군 on 12. 3. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"

@interface ViewController : UIViewController<FaceViewDelegate>
{
@private
    int _happiness;
@protected
    IBOutlet FaceView * _faceView;
    IBOutlet UISlider * _slider;
}

@property (nonatomic) int happiness;
@property (nonatomic, retain) IBOutlet FaceView * faceView;
@property (nonatomic, retain) IBOutlet UISlider * slider;

- (IBAction) happinessChanged:(UISlider*)sender;
- (float) smileForFaceView:(FaceView *)requestor;

@end
