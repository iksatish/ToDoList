//
//  TaskData.h
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskData : NSObject

@property (strong, nonatomic) NSString *taskInfo;
@property (strong, nonatomic) NSString *taskPriority;
@property (strong, nonatomic) NSString *taskCategory;
@property (strong, nonatomic) NSString *taskDateTime;

@end
