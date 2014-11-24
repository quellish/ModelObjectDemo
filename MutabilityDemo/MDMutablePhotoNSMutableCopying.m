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

- (id) copyWithZone:(NSZone *)__unused zone {
    MDPhotoNSCopying *result = [[MDPhotoNSCopying alloc] initWithIdentifier:[self identifier]];
    return result;
}

@end

@implementation MDPhotoNSCopying (MutableCopying)
- (id) mutableCopyWithZone:(NSZone *)__unused zone {
    MDMutablePhotoNSMutableCopying  *result = [[MDMutablePhotoNSMutableCopying alloc] initWithIdentifier:[self identifier]];
    return result;
}

@end