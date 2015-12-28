//
//  Photo.h
//  Shutterbug
//
//  Created by 다람군 on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Photo : NSManagedObject {
@private
}

+ (Photo*) photoWithFlickrData: (NSDictionary *)flickrData
        inManagedObjectContext: (NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * thumbnailURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uniqueId;
@property (nonatomic, retain) Photographer *whoTook;

- (void) processImageDataWithBlock:(void (^) (NSData* imageData)) processImage;

@end
