//
//  MDMutablePhoto.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDMutablePhotoNSMutableCopying.h"

@implementation MDMutablePhotoNSMutableCopying
@dynamic identifier;

- (instancetype) initWithIdentifier:(NSString *)anIdentifier {
    if ((self = [super initWithIdentifier:anIdentifier])){
        
    }
    return self;
}

/**
 *  We override copyWithZone: to return an instance of our immutable superclass.
 *
 */

- (id) copyWithZone:(NSZone *)__unused zone {
    MDPhotoNSCopying *result = [[MDPhotoNSCopying alloc] initWithIdentifier:[self identifier]];
    return result;
}

@end

/**
 *  Using a category to add this functionality to the immutable superclass is effective and keeps the superclass from
 *  needing any knowledge of it's subclasses.
 */

@implementation MDPhotoNSCopying (MutableCopying)
- (id) mutableCopyWithZone:(NSZone *)__unused zone {
    MDMutablePhotoNSMutableCopying  *result = [[MDMutablePhotoNSMutableCopying alloc] initWithIdentifier:[self identifier]];
    return result;
}

@end