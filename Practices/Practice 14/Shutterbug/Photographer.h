//
//  Photographer.h
//  Shutterbug
//
//  Created by 다람군 on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@class Photo;

@interface Photographer : NSManagedObject<MKAnnotation> 

+ (Photographer*) photographerWithFlickrData: (NSDictionary *)flickrData
                      inManagedObjectContext: (NSManagedObjectContext*)context;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *photos;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (readonly) NSString * title;

@property (readonly) Photo * representativePhoto;

@end
