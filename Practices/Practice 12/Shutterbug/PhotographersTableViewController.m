//
//  PhotographersTableViewController.m
//  Shutterbug
//
//  Created by 다람군 on 12. 5. 3..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "PhotographersTableViewController.h"
#import "Photographer.h"
#import "PhotosByPhotographerTableViewController.h"

@implementation PhotographersTableViewController

- (id) initInManagedObjectContext: (NSManagedObjectContext *)context
{
    if (self = [super init])
    {
        // Initialization code here.
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        request.entity = [NSEntityDescription entityForName:@"Photographer" inManagedObjectContext:context];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" 
                                                                                         ascending:YES
                                                                                          selector:@selector(caseInsensitiveCompare:)]];
        request.predicate = nil;
        request.fetchBatchSize = 20;
        
        NSFetchedResultsController * _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                                     managedObjectContext:context 
                                                                                                       sectionNameKeyPath:@"firstLetterOfName" 
                                                                                                                cacheName:@"MyPhotoCache"];
        [request release];
        
        self.fetchedResultsController = _fetchedResultsController;
        [_fetchedResultsController release];
        
        self.titleKey = @"name";
    }
    
    return self;   
}

- (void) managedObjectSelected:(NSManagedObject *)managedObject
{
    Photographer * photographer = (Photographer *)managedObject;
    PhotosByPhotographerTableViewController * photosByPhotographerTableViewController = [[PhotosByPhotographerTableViewController alloc] initWithPhotographer:photographer];
    [self.navigationController pushViewController:photosByPhotographerTableViewController animated:YES];
    [photosByPhotographerTableViewController release];
}

@end
