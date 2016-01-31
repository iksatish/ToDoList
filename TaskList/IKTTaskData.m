//
//  IKTTaskData.m
//  TaskList
//
//  Created by Satish Kumar R Kancherla on 1/30/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

#import "IKTTaskData.h"
#import "IKTGlobal.h"

@implementation IKTTaskData

- (void)getDataObjFromDict:(NSDictionary *)taskDict{
    _taskInfo = [taskDict valueForKey:[IKTGlobal sharedInstance].kTaskDesc];
    _taskPriority = [taskDict valueForKey:[IKTGlobal sharedInstance].kTaskPriority];
    _taskCategory = [taskDict valueForKey:[IKTGlobal sharedInstance].kTaskCategory];
    _taskDateTime = [taskDict valueForKey:[IKTGlobal sharedInstance].kTaskDateTime];
}

- (NSMutableDictionary *)getDictFromDataObj{
    NSMutableDictionary *taskDict = [[NSMutableDictionary alloc]init];
    [taskDict setValue:_taskInfo forKey:[IKTGlobal sharedInstance].kTaskDesc];
    [taskDict setValue:_taskPriority forKey:[IKTGlobal sharedInstance].kTaskPriority];
    [taskDict setValue:_taskCategory forKey:[IKTGlobal sharedInstance].kTaskCategory];
    [taskDict setValue:_taskDateTime forKey:[IKTGlobal sharedInstance].kTaskDateTime];
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
