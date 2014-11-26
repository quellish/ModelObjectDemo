//
//  MDPhotoPublicMutability.h
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "MDPhotoPrivateMutability.h"

@interface MDPhotoPublicMutability : MDPhotoPrivateMutability
@property (nonatomic, readwrite, copy) NSString	*identifier;
@end
