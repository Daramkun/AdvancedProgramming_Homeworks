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
#import "Photo.h"
#import "FlickrFetcher.h"

@implementation PhotographersTableViewController

@synthesize mapView, tableView;

- (MKMapView*) mapView
{
    if (!mapView) mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    return mapView;
}

#define MAP_BUTTON_TITLE @"Map"
#define LIST_BUTTON_TITLE @"List"

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if(!tableView && [self.view isKindOfClass:[UITableView class]])
        tableView = (UITableView*)self.view;
    
    self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    self.mapView.frame = self.view.bounds;
    [self.view addSubview:mapView];
    
    self.mapView.hidden = YES;
    self.mapView.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:MAP_BUTTON_TITLE style:UIBarButtonItemStyleBordered target:self action:@selector(toggleMap)] autorelease];
}

- (MKAnnotationView*) mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView * aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"foo"];
    aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    aView.leftCalloutAccessoryView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)] autorelease];
    aView.canShowCallout = YES;
    aView.annotation = annotation;
    
    return aView;
}

- (void) mapView:(MKMapView*)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    Photographer * photographer = nil;
    UIImageView * imageView = nil;
    
    if([view.annotation isKindOfClass:[Photographer class]])
        photographer = (Photographer*)view.annotation;
    
    if([view.leftCalloutAccessoryView isKindOfClass:[UIImageView class]])
        imageView = (UIImageView*)view.leftCalloutAccessoryView;
    
    if(photographer && imageView)
    {
        NSString * thumbnailURL = photographer.representativePhoto.thumbnailURL;
        if (thumbnailURL)
        {
            dispatch_queue_t downloader = dispatch_queue_create("map view downloader", NULL);
            dispatch_async(downloader, ^{
                UIImage * image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithURLString:thumbnailURL]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            });
            dispatch_release(downloader);
        }
    }
}

- (void) mapView:(MKMapView*)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self managedObjectSelected:view.annotation];
}

- (void) toggleMap
{
    if (self.mapView.hidden)
    {
        self.mapView.hidden = NO;
        self.tableView.hidden = YES;
        self.navigationItem.rightBarButtonItem.title = LIST_BUTTON_TITLE;
        if([self.mapView.annotations count] < 1)
        {
            NSFetchedResultsController * frc = self.fetchedResultsController;
			[self.mapView addAnnotations:[frc.managedObjectContext executeFetchRequest:frc.fetchRequest error:NULL]];
        }
    }
    else
    {
        self.mapView.hidden = YES;
        self.tableView.hidden = NO;
        self.navigationItem.rightBarButtonItem.title = MAP_BUTTON_TITLE;
    }
}

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
