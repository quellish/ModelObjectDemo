//
//  MDPhoto.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoNSCopying.h"

@interface MDPhotoNSCopying ()

@end

@implementation MDPhotoNSCopying
@synthesize identifier;
- (instancetype) initWithIdentifier:(NSString *)anIdentifier {
    if ((self = [super init])){
        identifier = [anIdentifier copy];
    }
    return self;
}

- (id) copyWithZone:(NSZone *)__unused zone {
    // Returning self is effective only under the following conditions:
    // 1. The object is immutable.
    // 2. The object does not have relationships to other objects
    return self;
}

@end
