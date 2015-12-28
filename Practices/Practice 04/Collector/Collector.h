//
//  Collector.h
//  Collector
//
//  Created by 다람군 on 12. 3. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Collector : NSObject
{
    NSMutableDictionary * counts;
}

- (void) collect : (id) anObject;

@property (readonly) int totalStringCount;
@property (readonly) int totalNumberCount;

@end
