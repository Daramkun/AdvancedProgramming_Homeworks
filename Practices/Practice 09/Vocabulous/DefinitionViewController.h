//
//  DefinitionViewController.h
//  Vocabulous
//
//  Created by 다람군 on 12. 4. 23..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefinitionViewController : UIViewController
{
    UIWebView * webView;
    NSString * word;
}

@property (copy) NSString * word;

@end
