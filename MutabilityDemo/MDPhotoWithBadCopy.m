//
//  MDPhotoWithCopy.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoWithBadCopy.h"

@implementation MDPhotoWithBadCopy
@synthesize identifier;
- (instancetype) initWithIdentifier:(NSString *)anIdentifier {
    if ((self = [super init])){
        identifier = anIdentifier;
    }
    return self;
}
@end
