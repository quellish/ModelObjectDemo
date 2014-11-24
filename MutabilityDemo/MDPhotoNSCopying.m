//
//  MDPhoto.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoNSCopying.h"

@interface MDPhotoNSCopying ()
@property   (nonatomic, readwrite, copy)    NSString    *identifier;
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
    return self;
}

@end
