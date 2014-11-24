//
//  MDPhotoCorrectImplementation.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoPrivateMutability.h"

@interface MDPhotoPrivateMutability ()
@property   (nonatomic, readwrite, copy)    NSString    *identifier;
@end

@implementation MDPhotoPrivateMutability
@synthesize identifier;
- (instancetype) initWithIdentifier:(NSString *)anIdentifier {
    if ((self = [super init])){
        identifier = [anIdentifier copy];
    }
    return self;
}
@end
