//
//  MDPhoto.h
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoPrivateMutability.h"

@interface MDPhotoNSCopying : NSObject<NSCopying>
@property (nonatomic, readonly, copy) NSString	*identifier;
- (instancetype) initWithIdentifier:(NSString *)anIdentifier;
@end
