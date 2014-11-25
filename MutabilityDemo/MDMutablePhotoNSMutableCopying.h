//
//  MDMutablePhoto.h
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoNSCopying.h"

@interface MDMutablePhotoNSMutableCopying : MDPhotoNSCopying
@property (nonatomic, readwrite, copy) NSString	*identifier;
@end

/**
 *  Category to provide NSMutableCopying to the MDPhotoNSCopying superclass
 */

@interface MDPhotoNSCopying (MutableCopying)<NSMutableCopying>
- (id) mutableCopyWithZone:(NSZone *)zone;
@end