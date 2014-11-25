//
//  MDMutablePhotoNSSecureCoding.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/25/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDMutablePhotoNSSecureCoding.h"

@implementation MDMutablePhotoNSSecureCoding
@synthesize identifier;

- (instancetype) initWithIdentifier:(NSString *)anIdentifier {
    if ((self = [super initWithIdentifier:anIdentifier])){
        // Because we redeclared the property, we also had to synthesize it again as well
        // Auto-synthesis would just use the superclass implementation, which would be read only
        // To have the property be writable, synthesize creates new storage independant of the superclass
        // which means the call to [super initWithIdentifier:] will not set the property on the correct storage.
        // So we have to do this again in the subclass.
        identifier = [anIdentifier copy];
    }
    return self;
}

#pragma mark NSCoping

/**
 *  We override copyWithZone: to return an instance of our immutable superclass.
 *
 */

- (id) copyWithZone:(NSZone *)__unused zone {
    MDPhotoNSSecureCoding *result = [[MDPhotoNSSecureCoding alloc] initWithIdentifier:[self identifier]];
    return result;
}

@end

#pragma mark NSMutableCopying

/**
 *  Using a category to add this functionality to the immutable superclass is effective and keeps the superclass from
 *  needing any knowledge of it's subclasses.
 */

@implementation MDPhotoNSSecureCoding (MutableCopying)
- (id) mutableCopyWithZone:(NSZone *)__unused zone {
    MDMutablePhotoNSSecureCoding  *result = [[MDMutablePhotoNSSecureCoding alloc] initWithIdentifier:[self identifier]];
    return result;
}

@end
