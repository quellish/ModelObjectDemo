//
//  MDPhotoPublicMutability.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoPublicMutability.h"

@implementation MDPhotoPublicMutability
@dynamic identifier;

- (instancetype) initWithIdentifier:(NSString *)anIdentifier {
    if ((self = [super initWithIdentifier:anIdentifier])){

    }
    return self;
}

@end
