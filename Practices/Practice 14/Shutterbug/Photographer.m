//
//  Photographer.m
//  Shutterbug
//
//  Created by 다람군 on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "Photographer.h"
#import "Photo.h"

@implementation Photographer

- (Photo*) representativePhoto
{
    return [self.photos anyObject];
}

- (CLLocationCoordinate2D) coordinate
{
    Photo * representativePhoto = [self representativePhoto];
    CLLocationCoordinate2D location;
    location.latitude = [representativePhoto.latitude doubleValue];
    location.longitude = [representativePhoto.longitude doubleValue];
    return location;
}

- (NSString*) title
{
    return self.name;
}

- (NSString *) firstLetterOfName
{
    return [[self.name substringToIndex:1] capitalizedString];
}

+ (Photographer*) photographerWithFlickrData: (NSDictionary *)flickrData
                      inManagedObjectContext: (NSManagedObjectContext*)context
{
    Photographer * photographer = nil;
    
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Photographer" inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", [flickrData objectForKey:@"ownername"]];
    
    NSError * error = nil;
    photographer = [[context executeFetchRequest:request error:&error] lastObject];
    
    if(!error && !photographer)
    {
        photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];
        photographer.name = [flickrData objectForKey:@"ownername"];
    }
    return photographer;
}

@dynamic name;
@dynamic photos;

@end
