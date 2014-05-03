//
//  TextFileHelperTest.m
//  HmuLibrary
//
//  Created by MURONAKA HIROAKI on 2014/05/03.
//  Copyright (c) 2014年 hmu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TextFileHelper.h"

@interface TextFileHelperTest : XCTestCase

@end

@implementation TextFileHelperTest

- (void)setUp
{
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testExistFile
{
    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Test" ofType:@"csv"];
    XCTAssertNotNil(filePath, @"%@", filePath);
}

-(void)testExistFileUseMainBundle
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"csv"];
    XCTAssertNil(filePath, @"%@", filePath);
}


-(void)testReadCsvNotExistFile
{
    BOOL result = [TextFileHelper readCsv:@"AGD" block:^(NSArray* cols) {
        XCTFail(@"not exist file.");
    }];
    
    XCTAssertFalse(result, @"AGD.csv is not exist.");
}

- (void)testReadCSVWithNoComment
{
    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Test" ofType:@"csv"];
    
    NSArray* expects = @[
                         @[@"12",@"34",@"56"],
                         @[@"abc",@"de",@"fgh", @""],
                         @[@"#",@" abcdefg",@"agd"],
                         @[@"ABC",@"",@"ABC"],
                         @[@"\"ABC", @"DEF\""],
                         @[@"",@"",@"",@"",@""],
                         @[@"END"]];

    __block int num = 0;
    
    [TextFileHelper readCsv:filePath block:^(NSArray* cols) {
        XCTAssertEqualObjects(expects[num], cols, @"index=%d", num);
        num++;
    }];
    
    XCTAssertEqual(num, expects.count, @"%d != %d", num, expects.count);
}

@end
