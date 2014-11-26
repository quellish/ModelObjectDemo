//
//  MDMutablePhotoNSSecureCoding.h
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/25/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoNSSecureCoding.h"

@interface MDMutablePhotoNSSecureCoding : MDPhotoNSSecureCoding
@property (nonatomic, readwrite, copy) NSString	*identifier;
@end

/**
 *  Category to provide NSMutableCopying to the MDPhotoNSCopying superclass
 */

@interface MDPhotoNSSecureCoding (MutableCopying)<NSMutableCopying>
- (id) mutableCopyWithZone:(NSZone *)zone;
@end