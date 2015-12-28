//
//  PhotographersTableViewController.h
//  Shutterbug
//
//  Created by 다람군 on 12. 5. 3..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface PhotographersTableViewController : CoreDataTableViewController
{

}

- (id) initInManagedObjectContext: (NSManagedObjectContext *)context;

@end
