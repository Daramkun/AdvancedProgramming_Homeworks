//
//  AskerViewController.h
//  LabelMover
//
//  Created by 진 재연 on 12. 5. 30..
//  Copyright (c) 2012년 daramkun@daram.pe.kr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AskerViewControllerDelegate;

@interface AskerViewController : UIViewController <UITextFieldDelegate>
{
    NSString * question;
    IBOutlet UILabel * questionLabel;
    IBOutlet UITextField * answerField;
    id<AskerViewControllerDelegate> delegate;
}

@property (copy) NSString * question;

@property (retain) IBOutlet UILabel * questionLabel;
@property (retain) IBOutlet UITextField * answerField;

@property (retain) id<AskerViewControllerDelegate> delegate;

@end

@protocol AskerViewControllerDelegate

- (void) askerViewController:(AskerViewController*)sender
              didAskQuestion:(NSString*)question
                andGotAnswer:(NSString*)answer;

@end
