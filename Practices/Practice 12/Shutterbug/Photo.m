//
//  Photo.m
//  Shutterbug
//
//  Created by 다람군 on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "Photo.h"
#import "Photographer.h"
#import "FlickrFetcher.h"

@implementation Photo

+ (Photo*) photoWithFlickrData: (NSDictionary *)flickrData
        inManagedObjectContext: (NSManagedObjectContext *)context
{
    Photo * photo = nil;
    
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId = %@", [flickrData objectForKey:@"id"]];
    
    NSError * error = nil;
    photo = [[context executeFetchRequest:request error:&error] lastObject];
    
    if(!error && !photo)
    {
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        photo.uniqueId = [flickrData objectForKey:@"id"];
        photo.title = [flickrData objectForKey:@"title"];
        photo.imageURL = [FlickrFetcher urlStringForPhotoWithFlickrInfo:flickrData format:FlickrFetcherPhotoFormatLarge];
        photo.whoTook = [Photographer photographerWithFlickrData:flickrData inManagedObjectContext:context];
    }
    return photo;
}

@dynamic imageURL;
@dynamic title;
@dynamic uniqueId;
@dynamic whoTook;

@end
