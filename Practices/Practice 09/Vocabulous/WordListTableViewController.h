//
//  WordListTableViewController.h
//  Vocabulous
//
//  Created by 다람군 on 12. 4. 18..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordListTableViewController : UITableViewController
{
@private
    NSMutableDictionary * words;
    NSArray * sections;
}

@end
