//
//  MDPhotoPublicMutabilityTests.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MutabilityDemo.h"
@interface MDPhotoPublicMutabilityTests : XCTestCase

@end

@implementation MDPhotoPublicMutabilityTests

- (Class)testClass {
    return [MDPhotoPublicMutability class];
}

- (void)testIdentifierWithMutableString {
    id                  testObject = nil;
    NSMutableString     *testString = nil;
    
    testString = [[NSMutableString alloc] initWithString:@"Foo"];
    testObject = [[[self testClass] alloc] initWithIdentifier:testString];
    
    XCTAssertTrue([[testObject identifier] isEqualToString:@"Foo"], @"Object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
    [testString appendString:@"Bar"];
    XCTAssertTrue([[testObject identifier] isEqualToString:@"Foo"], @"Object identifier does not match expectation, value was mutated. Actual value:%@", [testObject identifier]);
    
}

- (void)testIdentifierCanBeChanged {
    id                  testObject = nil;
    NSMutableString     *testString = nil;
    
    testString = [[NSMutableString alloc] initWithString:@"Foo"];
    testObject = [[[self testClass] alloc] initWithIdentifier:testString];
    
    XCTAssertTrue([[testObject identifier] isEqualToString:@"Foo"], @"Object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
    [testObject setIdentifier:@"Bar"];
    XCTAssertTrue([[testObject identifier] isEqualToString:@"Bar"], @"Object identifier does not match expectation, was not able to change identifier. Actual value:%@", [testObject identifier]);
    
}

@end
