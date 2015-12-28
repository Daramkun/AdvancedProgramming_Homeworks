//
//  ViewController.h
//  LabelMover
//
//  Created by 진 재연 on 12. 5. 30..
//  Copyright (c) 2012년 daramkun@daram.pe.kr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AskerViewController.h"

@interface ViewController : UIViewController <AskerViewControllerDelegate>
{
    IBOutlet UILabel * myLabel;
}

@property (retain) IBOutlet UILabel * myLabel;

@end
