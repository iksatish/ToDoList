//
//  TaskListTests.m
//  TaskListTests
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IKTViewController.h"

@interface TaskListTests : XCTestCase

@property (nonatomic) IKTViewController *homeVC;
@end

@implementation TaskListTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.homeVC = [[IKTViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.homeVC conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewConformsToUITableViewDataSource{
    XCTAssert([self.homeVC conformsToProtocol:@protocol(UITableViewDataSource)], "Doesnot confirm to UITableViewDataSource protocol ");
}

- (void)testTableViewConformsToIKTAddNewTaskDelegate{
    XCTAssert([self.homeVC conformsToProtocol:@protocol(IKTAddNewTaskDelegate)], "Doesnot confirm to IKTAddNewTaskDelegate protocol ");
}

- (void)testTableViewConformsToIKTMenuDelegate{
    XCTAssert([self.homeVC conformsToProtocol:@protocol(IKTMenuDelegate)], "Doesnot confirm to IKTMenuDelegate protocol ");
}

- (void)testTableViewConformsToMFMailComposeViewControllerDelegate{
    XCTAssert([self.homeVC conformsToProtocol:@protocol(MFMailComposeViewControllerDelegate)], "Doesnot confirm to MFMailComposeViewControllerDelegate protocol ");
}

- (void)testTableViewConformsToMFMessageComposeViewControllerDelegate{
    XCTAssert([self.homeVC conformsToProtocol:@protocol(MFMessageComposeViewControllerDelegate)], "Doesnot confirm to MFMessageComposeViewControllerDelegate protocol ");
}

- (void)testTableViewConformsToUITabBarDelegate{
    XCTAssert([self.homeVC conformsToProtocol:@protocol(UITabBarDelegate)], "Doesnot confirm to UITabBarDelegate protocol ");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
