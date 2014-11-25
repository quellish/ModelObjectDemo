//
//  MDPhotoNSSecureCoding.h
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/25/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDPhotoNSSecureCoding : NSObject<NSCopying,NSSecureCoding>
@property (nonatomic, readonly, copy) NSString	*identifier;
- (instancetype) initWithIdentifier:(NSString *)anIdentifier;
@end
