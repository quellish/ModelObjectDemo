//
//  MDPhotoNSSecureCoding.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/25/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoNSSecureCoding.h"

@implementation MDPhotoNSSecureCoding
@synthesize identifier;
- (instancetype) initWithIdentifier:(NSString *)anIdentifier {
    if ((self = [super init])){
        identifier = [anIdentifier copy];
    }
    return self;
}

#pragma mark NSCopying

- (id) copyWithZone:(NSZone *)__unused zone {
    // Returning self is effective only under the following conditions:
    // 1. The object is immutable.
    // 2. The object does not have relationships to other objects
    return self;
}

#pragma mark NSSecureCoding

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [self initWithIdentifier:[decoder decodeObjectOfClass:[NSString class] forKey:@"identifier"]])) {
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.identifier forKey:@"identifier"];;
}

+ (BOOL) supportsSecureCoding {
    return YES;
}

// Overriding these two NSObject methods allows us to specify a specific class for
// NSCoding and NSKeyedArchiving. This helps us ensure that subclasses return the correct class from keyed archiving
// In our case, we want to always return the immutable superclass from archiving.
- (Class) classForCoder {
    return [MDPhotoNSSecureCoding class];
}

- (Class) classForKeyedArchiver {
    return [MDPhotoNSSecureCoding class];
}

@end
