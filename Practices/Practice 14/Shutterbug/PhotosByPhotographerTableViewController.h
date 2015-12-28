//
//  PhotosByPhotographerTableViewController.h
//  Shutterbug
//
//  Created by 다람군 on 12. 5. 3..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataTableViewController.h"
#import "Photographer.h"

@interface PhotosByPhotographerTableViewController : CoreDataTableViewController
{

}

- (id) initWithPhotographer: (Photographer *)photographer;

@end
