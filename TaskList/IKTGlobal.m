//
//  IKTGlobal.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import "IKTGlobal.h"

@implementation IKTGlobal

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static IKTGlobal *sharedInstance;
    
    dispatch_once(&once, ^
                  {
                      sharedInstance = [self new];
                      sharedInstance.kTaskList_DataFile = @"testfile123.plist";
                      sharedInstance.kTaskDesc = @"taskDesc";
                      sharedInstance.kTaskPriority = @"taskPriority";
                      sharedInstance.kTaskCategory = @"taskCategory";
                      sharedInstance.kTaskDateTime = @"taskDateTime";
                      sharedInstance.kCategoryWork = @"WORK";
                      sharedInstance.kCategoryHome = @"HOME";
                      sharedInstance.kCategoryMisc = @"MISCELLANEOUS";
                      sharedInstance.kPriorityLow = @"LOW";
                      sharedInstance.kPriorityMedium = @"MEDIUM";
                      sharedInstance.kPriorityHigh = @"HIGH";

                  });
    
    return sharedInstance;
}
@end
