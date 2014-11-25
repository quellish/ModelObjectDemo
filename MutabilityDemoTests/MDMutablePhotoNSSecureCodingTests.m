//
//  MDMutablePhotoNSSecureCodingTests.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/25/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MutabilityDemo.h"

@interface MDMutablePhotoNSSecureCodingTests : XCTestCase

@end

@implementation MDMutablePhotoNSSecureCodingTests

- (Class)testClass {
    return [MDMutablePhotoNSSecureCoding class];
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

// Note: This uses a category in it's implementation, you must have the OTHER_LINKER_FLAG "-all_load" set for it to pass.
- (void)testCanMutableCopyObject {
    id                  testObject = nil;
    id                  copiedObject    =nil;
    NSMutableString     *testString = nil;
    
    testString = [[NSMutableString alloc] initWithString:@"Foo"];
    testObject = [[[self testClass] alloc] initWithIdentifier:testString];
    
    XCTAssertTrue([[testObject identifier] isEqualToString:@"Foo"], @"Object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
    copiedObject = [testObject mutableCopy];
    XCTAssertTrue([[copiedObject identifier] isEqualToString:@"Foo"], @"Copied object identifier does not match expectation. Actual value:%@", [testObject identifier]);
    
}

// Note: This uses a category in it's implementation, you must have the OTHER_LINKER_FLAG "-all_load" set for it to pass.
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

- (void) testCanArchiveObject {
    id                  testObject      = nil;
    id                  restoredObject  = nil;
    NSMutableString     *testString     = nil;
    NSData              *archive        = nil;
    
    testString = [[NSMutableString alloc] initWithString:@"Foo"];
    testObject = [[[self testClass] alloc] initWithIdentifier:testString];
    
    archive = [NSKeyedArchiver archivedDataWithRootObject:testObject];
    XCTAssertTrue([archive length] > 0, @"NSKeyedArchiver produced no data for object");
    
    restoredObject = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
    XCTAssertNotNil(restoredObject, @"NSKeyedUnarchiver was not able to unarchive object");
    
    // Keyed archiving should return an immutable object.
    XCTAssertFalse([restoredObject respondsToSelector:@selector(setIdentifier:)], @"Unarchived object does respond to writable selector.");
    
    XCTAssertTrue([[restoredObject identifier] isEqualToString:[testObject identifier]], @"Unarchived object property does not match source object. Test object:%@ Archive object:%@", [testObject identifier], [restoredObject identifier]);
    
}

@end
