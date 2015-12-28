//
//  PhotosByPhotographerTableViewController.m
//  Shutterbug
//
//  Created by 다람군 on 12. 5. 3..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "PhotosByPhotographerTableViewController.h"
#import "PhotoViewController.h"

@implementation PhotosByPhotographerTableViewController

- (id)initWithPhotographer: (Photographer *)photographer
{
    if (self = [super initWithStyle:UITableViewStylePlain])
    {
        // Initialization code here.
        NSManagedObjectContext * context = photographer.managedObjectContext;
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        request.entity = [NSEntityDescription entityForName:@"Photo"
                                     inManagedObjectContext:context];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                                          ascending:YES]];
        request.predicate = [NSPredicate predicateWithFormat:@"whoTook = %@", photographer];
        request.fetchBatchSize = 20;
        
        NSFetchedResultsController * _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request 
                                                                                                     managedObjectContext:context 
                                                                                                       sectionNameKeyPath:nil 
                                                                                                                cacheName:nil];
        [request release];
        
        self.fetchedResultsController = _fetchedResultsController;
        [_fetchedResultsController release];
        
        self.titleKey = @"title";
        self.searchKey = @"name";
    }
    
    return self;
}

- (void) managedObjectSelected:(NSManagedObject *)managedObject
{
    Photo * photo = (Photo*)managedObject;
    PhotoViewController * pvc = [[PhotoViewController alloc] init];
    pvc.photo = photo;
    [self.navigationController pushViewController:pvc animated:TRUE];
    [pvc release];
}

@end
