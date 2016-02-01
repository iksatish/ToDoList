//
//  MenuViewTests.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 2/1/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IKTMenuViewController.h"
@interface MenuViewTests : XCTestCase
@property (nonatomic) IKTMenuViewController *menuVC;
@end

@implementation MenuViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.menuVC = [[IKTMenuViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.menuVC conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewConformsToUITableViewDataSource{
    XCTAssert([self.menuVC conformsToProtocol:@protocol(UITableViewDataSource)], "Doesnot confirm to UITableViewDataSource protocol ");
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
