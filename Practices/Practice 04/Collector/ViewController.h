//
//  ViewController.h
//  Collector
//
//  Created by 다람군 on 12. 3. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collector.h"

@interface ViewController : UIViewController
{
    Collector * model;
    
    IBOutlet UILabel * totalStrings;
    IBOutlet UILabel * totalNumbers;
}

- (IBAction) collect : (UIButton*)sender;

@end
