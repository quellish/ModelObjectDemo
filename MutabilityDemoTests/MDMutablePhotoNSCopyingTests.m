//
//  MDMutablePhotoNSCopyingTests.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MutabilityDemo.h"


@interface MDMutablePhotoNSCopyingTests : XCTestCase

@end

@implementation MDMutablePhotoNSCopyingTests

- (Class)testClass {
    return [MDPhotoNSCopying class];
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

- (void)testCanCopyObject {
    id                  testObject = nil;
    id                  copiedObject    =nil;
    NSMutableString     *testString = nil;
    
    testString = [[NSMutableString alloc] initWithString:@"Foo"];
    testObject = [[[self testClass] alloc] initWithIdentifier:testString];
    
    XCTAssertTrue([[testObject identifier] isEqualToString:@"Foo"], @"Object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
    copiedObject = [testObject copy];
    XCTAssertTrue([[copiedObject identifier] isEqualToString:@"Foo"], @"Copied object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
}

- (void)testCopiedObjectDoesNotRespondsToWriteableSelector {
    id                  testObject = nil;
    id                  copiedObject    =nil;
    NSMutableString     *testString = nil;
    
    testString = [[NSMutableString alloc] initWithString:@"Foo"];
    testObject = [[[self testClass] alloc] initWithIdentifier:testString];
    
    XCTAssertTrue([[testObject identifier] isEqualToString:@"Foo"], @"Object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
    copiedObject = [testObject copy];
    XCTAssertFalse([copiedObject respondsToSelector:@selector(setIdentifier:)], @"Copied object does respond to writable selector.");
    
}

- (void)testCanMutableCopyObject {
    id                  testObject = nil;
    id                  copiedObject    =nil;
    NSMutableString     *testString = nil;
    
    testString = [[NSMutableString alloc] initWithString:@"Foo"];
    testObject = [[[self testClass] alloc] initWithIdentifier:testString];
    
    XCTAssertTrue([[testObject identifier] isEqualToString:@"Foo"], @"Object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
    copiedObject = [testObject mutableCopy];
    XCTAssertTrue([[copiedObject identifier] isEqualToString:[testObject identifier]], @"Copied object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
}

- (void)testMutableCopyObjectRespondsToWriteableSelector {
    id                  testObject = nil;
    id                  copiedObject    =nil;
    NSMutableString     *testString = nil;
    
    testString = [[NSMutableString alloc] initWithString:@"Foo"];
    testObject = [[[self testClass] alloc] initWithIdentifier:testString];
    
    XCTAssertTrue([[testObject identifier] isEqualToString:@"Foo"], @"Object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
    copiedObject = [testObject mutableCopy];
    XCTAssertTrue([copiedObject respondsToSelector:@selector(setIdentifier:)], @"Copied object does not respond to writable selector.");
    
}


@end
