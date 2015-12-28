//
//  Photographer.h
//  Shutterbug
//
//  Created by 다람군 on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photographer : NSManagedObject {
@private
}

+ (Photographer*) photographerWithFlickrData: (NSDictionary *)flickrData
                      inManagedObjectContext: (NSManagedObjectContext*)context;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *photos;

@end
