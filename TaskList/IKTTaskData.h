//
//  IKTTaskData.h
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKTTaskData : NSObject

@property (strong, nonatomic) NSString *taskInfo;
@property (strong, nonatomic) NSString *taskPriority;
@property (strong, nonatomic) NSString *taskCategory;
@property (strong, nonatomic) NSDate *taskDateTime;

- (void)getDataObjFromDict:(NSDictionary *)taskDict;
- (NSDictionary *)getDictFromDataObj;
+ (NSMutableArray *)convertFileContents:(NSArray*)fileContents;
+ (NSMutableArray *)convertForSaving:(NSArray *)allTasks;

@end
