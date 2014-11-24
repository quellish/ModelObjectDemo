//
//  MDPhoto.h
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDPhoto : NSObject
@property (nonatomic) NSString	*identifier;
- (instancetype) initWithIdentifier:(NSString *)anIdentifier;
@end
