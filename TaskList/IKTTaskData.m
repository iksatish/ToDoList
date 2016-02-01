//
//  IKTTaskData.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import "IKTTaskData.h"

@implementation IKTTaskData
    NSString *kTaskDesc = @"taskDesc";
    NSString *kTaskPriority = @"taskPriority";
    NSString *kTaskCategory = @"taskCategory";
    NSString *kTaskDateTime = @"taskDateTime";
    NSString *kTaskStatus = @"takStatus";

- (void)getDataObjFromDict:(NSDictionary *)taskDict{
    _taskInfo = [taskDict valueForKey: kTaskDesc];
    _taskPriority = [taskDict valueForKey: kTaskPriority];
    _taskCategory = [taskDict valueForKey: kTaskCategory];
    _taskDateTime = [taskDict valueForKey: kTaskDateTime];
    _taskStatus = [[taskDict valueForKey: kTaskStatus] boolValue];
}

- (NSMutableDictionary *)getDictFromDataObj{
    NSMutableDictionary *taskDict = [[NSMutableDictionary alloc]init];
    [taskDict setValue:_taskInfo forKey: kTaskDesc];
    [taskDict setValue:_taskPriority forKey: kTaskPriority];
    [taskDict setValue:_taskCategory forKey: kTaskCategory];
    [taskDict setValue:_taskDateTime forKey: kTaskDateTime];
    [taskDict setValue:[NSNumber numberWithBool:_taskStatus] forKey: kTaskStatus];
    return taskDict;
}

+ (NSMutableArray *)convertFileContents:(NSArray*)fileContents{
    NSMutableArray *modifiedContentsArray = [[NSMutableArray alloc]init];
    for(NSMutableDictionary *taskDict in fileContents){
        IKTTaskData *data = [[IKTTaskData alloc]init];
        [data getDataObjFromDict:taskDict];
        [modifiedContentsArray addObject:data];
    }
    return modifiedContentsArray;
}

+ (NSMutableArray *)convertForSaving:(NSArray *)allTasks{
    NSMutableArray *modifiedContentsArray = [[NSMutableArray alloc]init];
    for(IKTTaskData *taskData in allTasks){
        [modifiedContentsArray addObject:[taskData getDictFromDataObj]];
    }
    return modifiedContentsArray;
}
@end
