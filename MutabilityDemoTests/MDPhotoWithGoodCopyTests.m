//
//  MDPhotoWithGoodCopyTests.m
//  MutabilityDemo
//
//  Created by Dan Zinngrabe on 11/24/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MutabilityDemo.h"

@interface MDPhotoWithGoodCopyTests : XCTestCase

@end

@implementation MDPhotoWithGoodCopyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (Class)testClass {
    return [MDPhotoWithGoodCopy class];
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

@end
