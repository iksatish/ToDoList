//
//  IKTGlobal.h
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKTGlobal : NSObject

@property(strong, nonatomic)NSString *kTaskList_DataFile;
@property(strong, nonatomic)NSString *kTaskDesc;
@property(strong, nonatomic)NSString *kTaskPriority;
@property(strong, nonatomic)NSString *kTaskCategory;
@property(strong, nonatomic)NSString *kTaskDateTime;
@property(strong, nonatomic)NSString *kCategoryWork;
@property(strong, nonatomic)NSString *kCategoryHome;
@property(strong, nonatomic)NSString *kCategoryMisc;
@property(strong, nonatomic)NSString *kPriorityLow;
@property(strong, nonatomic)NSString *kPriorityMedium;
@property(strong, nonatomic)NSString *kPriorityHigh;

+ (instancetype)sharedInstance;

@end
