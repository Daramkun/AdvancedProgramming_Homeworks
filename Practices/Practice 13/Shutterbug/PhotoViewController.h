//
//  PhotoViewController.h
//  Shutterbug
//
//  Created by 진 재연 on 12. 5. 16..
//  Copyright (c) 2012년 daramkun@daram.pe.kr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotoViewController : UIViewController
{
    Photo * photo;
    IBOutlet UIScrollView * scrollView;
    IBOutlet UIImageView * imageView;
    IBOutlet UIActivityIndicatorView * spinner;
}

@property (retain) Photo * photo;

@end
